addpath('D:\Files\OneDrive - TU Eindhoven\03 Education\01 Courses\4GB20 Robot Arm\Github\4GB20-Group-4\Kinematics');
addpath('D:\Files\OneDrive - TU Eindhoven\03 Education\01 Courses\4GB20 Robot Arm\Github\4GB20-Group-4');
IK = load('eqn_IK_robotarm.mat');
%%
r = 165;
theta = 0;
z = 2; %

% [Rx, Rz] = fcn_IK(r, z, IK)
%% IK
posArray = ArmPos;
posArray.D = [r,z];
posArray = posArray.DtoC();
posArray = KineMod.IK_MAU(posArray.C,false);

phiR = theta
phiX = posArray.phiX
phiZ = posArray.phiZ