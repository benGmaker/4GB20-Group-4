clear all; close all; clc;
%% General script that runs the robot arm
% Loading the necessary subfolders
addpath("Kinematics")
addpath("Trajectory")
addpath("Calibration")
IK = load("eqn_IK_robotarm.mat");

%% Parameters that can be changed
% fs = 2048; % Simulation frequency
fs = 4096; % Real-world frequency

% Offsets that come from the calibration. These are used as starting
% positions, since after homing the robot is approximately at [0 0 0]
offsetR=-0.2036;
offsetX=0.0277;
offsetZ=0.2494;

% The different heights for moving and picking/placing bolts.
z_pickup = 24;      % Pickup height of the bolts
z_moving = 60;      % Safe moving height over the bolts, even with bolt clamped

% While picking a bolt a pause is added to ensure that the solenoid has
% enough time to clamp the bolt. At the end a constant second is added, so
% the robot arm will not drift off if it has any speed left over
pause_bolt=0.5;     % The pause above a bolt in seconds
pause_end=1;        % The pause at the end in seconds

% General expression for the offset of the robot arm center wrt the
% plate
% alpha = 100; Simulatie
alpha = 90; % physical robot
beta = 0; % offset from center line of the plate (calibration line) (minus for offset to the source grid)

% Constraints on the movement of the robot
armax=75;            % Maximum acceleration r direction in mm/s^2
athetamax=10;        % Maximum acceleration theta direction in mm/s^2
azmax=75;            % Maximum acceleration z direction in mm/s^2
vmax=75;             % Maximum velocity in mm/s

%% Calibration
% The full position of the arm is calculated for the offsets, this is done
% for the conversion between the motorangles and the cylindrical frame.
calpos(1) = ArmPos;
calpos(1).phiX = pi/2+offsetX;
calpos(1).phiZ = offsetZ;
calpos(1) = calpos(1).phiZXtoFullpos(false);

% The coordinates of the cylindrical frame are read from the above
% expression
r_init = calpos(1).D(1);       % Initial r of the EE
theta_init = offsetR;     % Initial theta of the EE
z_init = calpos(1).D(2);        % Initial z of the EE

%% Load the GUI
run('GUI.mlapp')
disp(sprintf("First select the desired positions in the GUI (pop-up) and click confirm. \nNext select the Command Window and press any key."))
pause()

%% GUI conversion to cylindrical coordinate frame
% The cylindrical coordinates are calculated in radians for all positions
% that are selected in the GUI
[r_s,theta_s] = distance_and_angle(source, 'source', alpha, beta);
[r_p,theta_p] = distance_and_angle(print, 'print', alpha, beta);
theta_s = deg2rad(theta_s);
theta_p = deg2rad(theta_p);

%% Path
% In PositionsToArray the outer positions of the path are listed into an
% array, so the path can be made between these
CoordinatePath = PositionsToArray(r_init,theta_init,z_init,r_s,theta_s,r_p,theta_p,z_pickup,z_moving);

% The full list of all points is made with fcn_acceleration, which
% calculates it from the constraints on velocity and acceleration
[coords] = fcn_acceleration(CoordinatePath,armax,athetamax,azmax,vmax,fs,pause_bolt,pause_end);

%% Inverse kinematics
% The motorangles are calculated from the cylindrical frame using the IK
tic
r=coords(1,:);
phiR=coords(2,:);
z=coords(3,:);
solenoid=coords(4,:);
for j=1:length(r)
    posArray(j) = ArmPos;
    posArray(j).D = [r(j),z(j)];
    posArray(j) = posArray(j).DtoC();
    posArray(j) = KineMod.IK_MAU(posArray(j).C,false);
end
% end
toc

% phiX and phiZ are read out, so they can be used
for i=1:length(posArray)
    phiX(i) = pi/2 - posArray(i).phiX;
    phiZ(i) = posArray(i).phiZ;
end

% The first 15 seconds of initial position are added, such that the time
% will be the same as in the physical robot
phiR=[phiR(1)*ones(1,15*fs) phiR];
phiX=[phiX(1)*ones(1,15*fs) phiX];
phiZ=[phiZ(1)*ones(1,15*fs) phiZ];
solenoid=[solenoid(1)*ones(1,15*fs) solenoid];

% Time vector
t = 0:1/fs:(length(phiX)-1)/fs;
%% Figuuuur
figure(1)
hold on
plot(t,phiX)
plot(t,phiZ)
plot(t,phiR)

legend('phiX','phiZ','phiR','solenoid')
title('Angles of robot arm')
xlabel('Time [s]')
ylabel('Angle [rad]')

% Figure solenoid
figure(2)
plot(t,solenoid)
legend('solenoid')
title('Signal for solenoid')
ylim([-1 2])
xlabel('Time [s]')
ylabel('Value')

% Figure combined
figure(3)
left_color = [0 0 0];
right_color = [0 0 0];
set(figure(3),'defaultAxesColorOrder',[left_color; right_color]);

title('Angles of robot arm')
yyaxis left
xlabel('Time [s]')
ylabel('Angle [rad]')

hold on
plot(t,phiX,'-b');
plot(t,phiZ,'-m');
plot(t,phiR,'-r');

yyaxis right
ylabel('Signal value')
plot(t,solenoid,'-k');
ylim([-1 2])
yticks(-1:1:2)
legend('phiX','phiZ','phiR','solenoid')

%% Timeseries
ref_X = timeseries(phiX',t);
ref_Z = timeseries(phiZ',t);
ref_R = timeseries(phiR',t);
ref_solenoid = timeseries(solenoid',t);
