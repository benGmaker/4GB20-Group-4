%% Initialize robotarm
fs = 2048;
Ts = 1/fs;

nSamplesForVisualization = 200;

initialAngleKrukX = 0.809091366467325; % [rad]
initialAngleKrukZ = 0.025113778764355; % [rad]

%% Trajectory
t_sim = 100;
n = t_sim*fs;

t = 0:t_sim/n:t_sim;
% R = linspace(-pi/4, pi/4,   n+1);
% X = linspace(0.1,   1.2,    n+1);
% Z = linspace(-0.3,  0.2,    n+1);

w = 2*pi*10;
R = sin(w*t);
X = linspace(0,   0,    n+1);
Z = linspace(0,  0,    n+1);

ref_R = timeseries(R,t);
ref_X = timeseries(X,t);
ref_Z = timeseries(Z,t);
