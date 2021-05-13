% General script that runs the robot arm

 

clear all; close all; clc;

 
IK = load("iets.mat");
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

 

initR = 200;
initTheta = 0;
initZ = 10;
z = 20;

 

%%
[r_s,theta_s] = distance_and_angle(source, 'source', alpha, beta)
[r_p,theta_p] = distance_and_angle(print, 'print', alpha, beta)

 

%% Path
CoordinatePath = PositionsToArray(initR,initTheta,initZ,r_s,theta_s,r_p,theta_p,z);
[Rx, Rz] = fcn_IK(CoordinatePath(:,1), CoordinatePath(:,3), IK);
% startPos = ArmPos;
% startPos.D = [220,40];
% startPos.theta = 10;
% startPos = startPos.DtoC;
% endPos = ArmPos;
% endPos.D = [210,40];
% endPos.theta = -10;

% FourStopLinearPath(startPos,endPos,50)

%% Inverse kinematics

 
i=1;
% for i=1:length(Rx)-1
 
pos(1) = ArmPos;
pos(1).phiX = Rx(i);
pos(1).phiZ = Rz(i);
pos(1) = pos(1).phiZXtoFullpos(false);

pos(2) = ArmPos;
pos(2).phiX = Rx(i+1);
pos(2).phiZ = Rz(i+1);
pos(2) = pos(2).phiZXtoFullpos(false);

n = 2048;
r = linspace(pos(1).D(1), pos(2).D(1), n);
z = linspace(pos(1).D(2), pos(2).D(2), n);
% r = linspace(CoordinatePath(1,i), CoordinatePath(1,i+1), n);
% z = linspace(CoordinatePath(3,i), CoordinatePath(3,i+1), n);

tic
posArray = ArmPos.empty([0,n]);
for j=1:n
    posArray(j) = ArmPos;
    posArray(j).D = [r(j),z(j)];
    posArray(j) = posArray(j).DtoC();
    posArray(j) = KineMod.IK_MAU(posArray(j).C,false);
end
toc

 

% end