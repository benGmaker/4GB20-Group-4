clear all; close all; clc;
%% General script that runs the robot arm
fs = 2048; % Simulation frequency
% fs = 4096; % Real-world frequency

IK = load("eqn_IK_robotarm.mat");
addpath("Kinematics")
addpath("Trajectory")

%% Load the GUI
run('GUI.mlapp')
disp(sprintf("First select the desired positions in the GUI (pop-up) and click confirm. \nNext select the Command Window and press any key."))
pause()

%% Calibration
% Default heights
z_pickup = 24;      % Pickup height of the bolts
z_moving = 50;      % Safe moving height over the bolts, even with bolt clamped

% This needs to be automatically adjusted by calibration.
r_init = 200;       % Initial r of the EE
theta_init = 0;     % Initial theta of the EE
z_init = 60;        % Initial z of the EE

alpha = 90; % offset from the plate
beta = 0; % offset from center line of the plate (calibration line) (minus for offset to the source grid)

%% GUI conversion to cylindrical coordinate frame
[r_s,theta_s] = distance_and_angle(source, 'source', alpha, beta);
[r_p,theta_p] = distance_and_angle(print, 'print', alpha, beta);
theta_s = deg2rad(theta_s);
theta_p = deg2rad(theta_p);

%% Path
% In PositionsToArray the outer positions of the path are listed into an
% array, so the path can be made between these
CoordinatePath = PositionsToArray(r_init,theta_init,z_init,r_s,theta_s,r_p,theta_p,z_pickup,z_moving);

vel = 100; % [mm/s] End-effector velocity (CHANGE THIS IF YOU WANT TO GO FASTER OR SLOWER)

[CoordinatePath, L] = fcn_time_distance_trajectory(CoordinatePath, vel, fs);

%% Inverse kinematics
ni = 0;
tic
phiR=[];
for i=1:length(CoordinatePath)-1
    n = CoordinatePath(4,i+1);
    r = linspace(CoordinatePath(1,i), CoordinatePath(1,i+1), n);
    z = linspace(CoordinatePath(3,i), CoordinatePath(3,i+1), n);
    phiR=[phiR,linspace(CoordinatePath(2,i), CoordinatePath(2,i+1), n)];
    
    for j=1:n
        posArray(ni+j) = ArmPos;
        posArray(ni+j).D = [r(j),z(j)];
        posArray(ni+j) = posArray(ni+j).DtoC();
        posArray(ni+j) = KineMod.IK_MAU(posArray(ni+j).C,false);
    end
    ni = ni + n;
end
toc

% phiX and phiZ
for i=1:length(posArray)
    phiX(i) = posArray(i).phiX;
    phiZ(i) = posArray(i).phiZ;
end

% Time vector
t = 0:1/fs:(ni-1)/fs;
%% Figuuuur
figure(1)
hold on
plot(t,phiX)
plot(t,phiZ)
plot(t,phiR)
legend('phiX','phiZ','phiR')
title('Angles of robot arm')
xlabel('Time [s]')
ylabel('Angle [rad]')

%% Timeseries

ref_X = timeseries([t;phiX]);
ref_Z = timeseries([t;phiZ]);
ref_R = timeseries([t;phiR]);
