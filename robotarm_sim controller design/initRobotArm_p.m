%% Initialize robotarm
Tsim = 10;
fs = 2048;
Ts = 1/fs;

stepX = 0;
stepZ = 0;
stepR = 0.5;

nSamplesForVisualization = 200;
initialAngleKrukX = 0.809091366467325; % [rad]
initialAngleKrukZ = 0.025113778764355; % [rad]  

t = 0:Ts:Tsim;
phiX = zeros(1,length(t)) + initialAngleKrukX + stepX;
phiZ = zeros(1,length(t)) + initialAngleKrukZ + stepZ;
phiR = zeros(1,length(t)) + stepR;
solenoid =  zeros(1,length(t));

ref_X = timeseries(phiX',t);
ref_Z = timeseries(phiZ',t);
ref_R = timeseries(phiR',t);
ref_solenoid = timeseries(solenoid',t);

controller_R = load('Controllers\Controller_R.mat');
controller_X = load('Controllers\Controller_X.mat');
controller_Z = load('Controllers\Controller_Z.mat');
