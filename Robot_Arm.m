% General script that runs the robot arm

clear all; close all; clc;

addpath("Kinematics")
addpath("Trajectory")

%% Load the GUI
run('GUI.mlapp')

disp(sprintf("First select the desired positions in the GUI (pop-up) and click confirm. \nNext select the Command Window and press any key."))
pause()

%% Settings
% This needs to be automatically adjusted by calibration.

alpha = 10; % offset from the plate
beta = 0; % offset from center line of the plate (calibration line) (minus for offset to the source grid)

initR = 100;
initTheta = 0;
initZ = 60;
z = 24;

%%
[r_s,theta_s] = distance_and_angle(source, 'source', alpha, beta)
[r_p,theta_p] = distance_and_angle(print, 'print', alpha, beta)

%% Path
CoordinatePath = PositionsToArray(initR,initTheta,initZ,r_s,theta_s,r_p,theta_p,z);

% startPos = ArmPos;
% startPos.D = [220,40];
% startPos.theta = 10;
% startPos = startPos.DtoC;
% endPos = ArmPos;
% endPos.D = [210,40];
% endPos.theta = -10;

% FourStopLinearPath(startPos,endPos,50)

%% Inverse kinematics

for i=1:length(CoordinatePath(:,1))-1

pos(1) = ArmPos;
pos(1).phiX = CoordinatePath(i,1);
pos(1).phiZ = CoordinatePath(i,2);
pos(1) = pos(1).phiZXtoFullpos(false)

pos(2) = ArmPos;
pos(2).phiX = CoordinatePath(i+1,1);
pos(2).phiZ = CoordinatePath(i+1,2);
pos(2) = pos(2).phiZXtoFullpos(false);

n = 2048;
r = linspace(CoordinatePath(1,i), CoordinatePath(1,i+1), n);
z = linspace(CoordinatePath(3,i), CoordinatePath(3,i+1), n);

tic
posArray = ArmPos.empty([0,n]);
for j=1:n
    posArray(j) = ArmPos;
    posArray(j).D = [r(j),z(j)];
    posArray(j) = posArray(j).DtoC();
    posArray(j) = KineMod.IK_MAU(posArray(j).C, false);
end
toc

end


