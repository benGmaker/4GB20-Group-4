clear all; close all; clc;
%% General script that runs the robot arm
addpath("Kinematics")
addpath("Trajectory")
addpath("Calibration")
IK = load("eqn_IK_robotarm.mat");

%% Parameters that can be changed
% fs = 2048; % Simulation frequency
fs = 4096; % Real-world frequency

offsetR=-0.0653;
offsetX=0.0211;
offsetZ=0.2538;

z_pickup = 24;      % Pickup height of the bolts
z_moving = 50;      % Safe moving height over the bolts, even with bolt clamped

pause_bolt=0.5;     % The pause above a bolt in seconds
pause_end=1;        % The pause at the end in seconds

% alpha = 100; Simulatie
alpha = 90; % physical robot
beta = 0; % offset from center line of the plate (calibration line) (minus for offset to the source grid)

armax=25;            % Maximum acceleration r direction in mm/s^2
athetamax=35;        % Maximum acceleration theta direction in mm/s^2
azmax=25;            % Maximum acceleration z direction in mm/s^2
vmax=100;            % Maximum velocity in mm/s

%% Calibration
calpos(1) = ArmPos;
calpos(1).phiX = offsetX;
calpos(1).phiZ = offsetZ;
calpos(1) = calpos(1).phiZXtoFullpos(false);

r_init = calpos(1).D(1);       % Initial r of the EE
theta_init = offsetR;     % Initial theta of the EE
z_init = calpos(1).D(2);        % Initial z of the EE

%% Load the GUI
run('GUI.mlapp')
disp(sprintf("First select the desired positions in the GUI (pop-up) and click confirm. \nNext select the Command Window and press any key."))
pause()

%% GUI conversion to cylindrical coordinate frame
[r_s,theta_s] = distance_and_angle(source, 'source', alpha, beta);
[r_p,theta_p] = distance_and_angle(print, 'print', alpha, beta);
theta_s = deg2rad(theta_s);
theta_p = deg2rad(theta_p);

%% Path
% In PositionsToArray the outer positions of the path are listed into an
% array, so the path can be made between these
CoordinatePath = PositionsToArray(r_init,theta_init,z_init,r_s,theta_s,r_p,theta_p,z_pickup,z_moving);

[coords] = fcn_acceleration(CoordinatePath,armax,athetamax,azmax,vmax,fs,pause_bolt,pause_end);

%% Inverse kinematics
tic
% phiR=[];
% for i=1:length(CoordinatePath)-1
%     n = CoordinatePath(5,i+1);
%     r = linspace(CoordinatePath(1,i), CoordinatePath(1,i+1), n);
%     z = linspace(CoordinatePath(3,i), CoordinatePath(3,i+1), n);
%     phiR=[phiR,linspace(CoordinatePath(2,i), CoordinatePath(2,i+1), n)];
%     solenoid = [solenoid,linspace(CoordinatePath(4,i), CoordinatePath(4,i), n)];
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

% phiX and phiZ
for i=1:length(posArray)
    phiX(i) = pi/2 - posArray(i).phiX;
    phiZ(i) = posArray(i).phiZ;
end

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
