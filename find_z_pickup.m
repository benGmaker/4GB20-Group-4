%%
r = 1.931320791582797e+02;
theta = 0.370891288812662;
z = 24; % this height is alright

%% IK
posArray = ArmPos;
posArray.D = [r,z];
posArray = posArray.DtoC();
posArray = KineMod.IK_MAU(posArray.C,false);

phiR = theta;
phiX = posArray.phiX;
phiZ = posArray.phiZ;

%% Sim trajectory
fs = 2048;
Ts = 1/fs;
t = 0:Ts:500;
len = length(t);

ref_R = timeseries(phiR*ones(1,len), t);
ref_X = timeseries(phiX*ones(1,len), t);
ref_Z = timeseries(phiZ*ones(1,len), t);



