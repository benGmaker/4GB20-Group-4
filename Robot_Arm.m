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

 

alpha = 80; % offset from the plate
beta = 0; % offset from center line of the plate (calibration line) (minus for offset to the source grid)

 

r_init = 240;
theta_init = 0;
z_init = 45;
z_pickup = 24;
z_moving = 50;

 

%%
[r_s,theta_s] = distance_and_angle(source, 'source', alpha, beta);
[r_p,theta_p] = distance_and_angle(print, 'print', alpha, beta);
theta_s = deg2rad(theta_s);
theta_p = deg2rad(theta_p);


%% Path
CoordinatePath = PositionsToArray(r_init,theta_init,z_init,r_s,theta_s,r_p,theta_p,z_pickup,z_moving);
[Rx, Rz] = fcn_IK(CoordinatePath(1,:), CoordinatePath(3,:), IK);
% startPos = ArmPos;
% startPos.D = [220,40];
% startPos.theta = 10;
% startPos = startPos.DtoC;
% endPos = ArmPos;
% endPos.D = [210,40];
% endPos.theta = -10;

% FourStopLinearPath(startPos,endPos,50)

%% Inverse kinematics
tic
n = 2048;
posArray = ArmPos.empty([0,n*(length(Rx)-1)]);
phiR=[];
for i=1:length(Rx)-1
    
pos(2*(i-1)+1) = ArmPos;
pos(2*(i-1)+1).phiX = Rx(i);
pos(2*(i-1)+1).phiZ = Rz(i);
pos(2*(i-1)+1) = pos(2*(i-1)+1).phiZXtoFullpos(false);

pos(2*(i-1)+2) = ArmPos;
pos(2*(i-1)+2).phiX = Rx(i+1);
pos(2*(i-1)+2).phiZ = Rz(i+1);
pos(2*(i-1)+2) = pos(2*(i-1)+2).phiZXtoFullpos(false);


r = linspace(pos(2*(i-1)+1).D(1), pos(2*(i-1)+2).D(1), n);
z = linspace(pos(2*(i-1)+1).D(2), pos(2*(i-1)+2).D(2), n);
phiR=[phiR,linspace(CoordinatePath(2,i), CoordinatePath(2,i+1),n)];


for j=1:n
    posArray(n*(i-1)+j) = ArmPos;
    posArray(n*(i-1)+j).D = [r(j),z(j)];
    posArray(n*(i-1)+j) = posArray(n*(i-1)+j).DtoC();
    posArray(n*(i-1)+j) = KineMod.IK_MAU(posArray(n*(i-1)+j).C,false);
end

end
toc

for i=1:(length(Rx)-1)*n
    phiX(i) = posArray(i).phiX;
    phiZ(i) = posArray(i).phiZ;
end
%% Figuuuur
figure()
hold on
plot(1:(length(Rx)-1)*n,phiX)
plot(1:(length(Rx)-1)*n,phiZ)
plot(1:(length(Rx)-1)*n,phiR)
legend('phiX','phiZ','phiR')