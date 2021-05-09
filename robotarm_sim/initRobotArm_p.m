%% Initialize robotarm
fs = 2048;
Ts = 1/fs;


initialAngleKrukX = 0.809091366467325; % [rad]
initialAngleKrukZ = 0.025113778764355; % [rad]

%% Trajectory
% Time vector
t_sim = 100;    % [s] Simulation duration (SHOULD BE EQUAL TO VALUE IN SIMULINK)
n = t_sim*fs;   % [-] Number of samples (based on sampling frequency)

t = 0:t_sim/n:t_sim;

% Example Trajectory for R, X, and Z (To be run with feedback)
% R = linspace(-pi/4, pi/4,   n+1);
% X = linspace(0.1,   1.2,    n+1);
% Z = linspace(-0.3,  0.2,    n+1);

% Sine sweep for system identification
Z = linspace(0,  0,    n+1);        % Keep this constant for now

% Turn into timeseries for Simulink
ref_R = timeseries(R',t);
ref_X = timeseries(X',t);
ref_Z = timeseries(Z',t);

