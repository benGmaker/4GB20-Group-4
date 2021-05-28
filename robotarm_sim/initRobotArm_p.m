%% Initialize robotarm
fs = 2048;
Ts = 1/fs;

nSamplesForVisualization = 200;

initialAngleKrukX = 0.809091366467325; % [rad]
initialAngleKrukZ = 0.025113778764355; % [rad]


controller_R = load('C:\REPO\Controller_R.mat');
controller_X = load('C:\REPO\Controller_X.mat');
controller_Z = load('C:\REPO\Controller_Z.mat');