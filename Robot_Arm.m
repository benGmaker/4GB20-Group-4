clear all; close all; clc;
% General script that runs the robot arm

z_pickup = 24;      % Pickup height of the bolts
z_moving = 50;      % Safe moving height over the bolts, even with bolt clamped
 
% This needs to be taken over by calibration
r_init = 200;       % Initial r of the EE
theta_init = 0;     % Initial theta of the EE
z_init = 60;        % Initial z of the EE


 

IK = load("eqn_IK_robotarm.mat");
addpath("Kinematics")
addpath("Trajectory")


%% Load the GUI



run('GUI.mlapp')
disp(sprintf("First select the desired positions in the GUI (pop-up) and click confirm. \nNext select the Command Window and press any key."))
pause()

%% Calibration
% This needs to be automatically adjusted by calibration.

alpha = 100; % offset from the plate
beta = 0; % offset from center line of the plate (calibration line) (minus for offset to the source grid)

% r_init = 200;       % Initial r of the EE
% theta_init = 0;     % Initial theta of the EE
% z_init = 60;        % Initial z of the EE

%% GUI conversion to cylindrical coordinate frame
[r_s,theta_s] = distance_and_angle(source, 'source', alpha, beta);
[r_p,theta_p] = distance_and_angle(print, 'print', alpha, beta);
theta_s = deg2rad(theta_s);
theta_p = deg2rad(theta_p);

%% Path
% In PositionsToArray the outer positions of the path are listed into an
% array, so the path can be made between these
CoordinatePath = PositionsToArray(r_init,theta_init,z_init,r_s,theta_s,r_p,theta_p,z_pickup,z_moving);

%% Inverse kinematics
tic
n = 2048;   % Number of samples per path part
phiR=[];
for i=1:length(CoordinatePath)-1

r = linspace(CoordinatePath(1,i), CoordinatePath(1,i+1), n);
z = linspace(CoordinatePath(3,i), CoordinatePath(3,i+1), n);
phiR=[phiR,linspace(CoordinatePath(2,i), CoordinatePath(2,i+1),n)];

for j=1:n
    posArray(n*(i-1)+j) = ArmPos;
    posArray(n*(i-1)+j).D = [r(j),z(j)];
    posArray(n*(i-1)+j) = posArray(n*(i-1)+j).DtoC();
    posArray(n*(i-1)+j) = KineMod.IK_MAU(posArray(n*(i-1)+j).C,false);
end

end
toc

for i=1:(length(CoordinatePath)-1)*n
    phiX(i) = posArray(i).phiX;
    phiZ(i) = posArray(i).phiZ;
end
%% Figuuuur
figure()
hold on
plot(1:(length(CoordinatePath)-1)*n,phiX)
plot(1:(length(CoordinatePath)-1)*n,phiZ)
plot(1:(length(CoordinatePath)-1)*n,phiR)
legend('phiX','phiZ','phiR')

%% Timeseries
t=linspace(0,16*(length(CoordinatePath)-1),n*(length(CoordinatePath)-1)); % @128Hz
ref_X = timeseries([t;phiX]);
ref_Z = timeseries([t;phiZ]);
ref_R = timeseries([t;phiR]);
