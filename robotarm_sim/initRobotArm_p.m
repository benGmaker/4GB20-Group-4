clear all; close all; clc
%% Initialize robotarm
fs = 2048;
Ts = 1/fs;

nSamplesForVisualization = 200;

initialAngleKrukX = 0.809091366467325; % [rad]
initialAngleKrukZ = 0.025113778764355; % [rad]

%% Trajectory
% Time vector
t_sim = 5;     % [s] Simulation duration (SHOULD BE EQUAL TO VALUE IN SIMULINK)
n = t_sim*fs;   % [-] Number of samples (based on sampling frequency)

t = 0:Ts:t_sim;

% RANGE: 
    % R: -pi/2 < R < pi/2
    % X: 0.2 < X < pi/2 - 0.1
    % Z: -0.4 < Z < 0.3

% Example Trajectory for R, X, and Z (To be run with feedback)
% R = linspace(-pi/4, pi/4,   n+1);
% X = linspace(0.3,   1.2,    n+1);
% Z = linspace(-0.3,  0.2,    n+1);

% 20 Hz sine for system identification
% R = sin(2*pi*20*t);                     % Just a sine for validation
% X = sin(2*pi*20*t);                     % Keep this constant for now
% Z = sin(2*pi*20*t);                     % Keep this constant for now

% 1 Hz input signal with equilibrium around middle of range of motion
R = sin(2*pi*t);
X = 0.8 + 0.2*sin(2*pi*t);
Z = 0.2*sin(2*pi*t);


% Multisine for system ID
% expo = 0:12;
% multisine = zeros(1, n+1);
% for i = 1:length(expo)
%     multisine = multisine + sin(2*pi*2^(expo(i))*t);
% end
% multisine = multisine/(max(abs(multisine)));
% % 
% R = multisine;
% X = 0.5*multisine;
% Z = 0.5*multisine;

% White noise
% R = randn(1, n+1);
% X = randn(1, n+1);
% Z = randn(1, n+1);

%% Finalizing data

dR = [diff(R)/Ts, 0];
dX = [diff(X)/Ts, 0];
dZ = [diff(Z)/Ts, 0];

ddR = [diff(dR)/Ts, 0];
ddX = [diff(dX)/Ts, 0];
ddZ = [diff(dZ)/Ts, 0];

% Turn into timeseries for Simulink
ref_R = timeseries(R',t);
ref_X = timeseries(X',t);
ref_Z = timeseries(Z',t);

ref_dR = timeseries(dR',t);
ref_dX = timeseries(dX',t);
ref_dZ = timeseries(dZ',t);

ref_ddR = timeseries(ddR',t);
ref_ddX = timeseries(ddX',t);
ref_ddZ = timeseries(ddZ',t);

%% Feedforward (UNCOMMENT THE MODEL YOU WANT TO USE)
% Model trained on multisine 
% FF_R_den = 154.7055;
% FF_R_num = [1.0000, 18.3051, 15.7647];
% 
% FF_X_den = 128.4965;
% FF_X_num = [1.0000, 18.7716, 20.4517];
% 
% FF_Z_den = 17.8826;
% FF_Z_num = [1.0000, 43.5519, 48.2345];

% Model trained on White Noise:
% FF_R_den = 120.9983;
% FF_R_num = [1.0000, 18.0197, 33.4285];
% 
% FF_X_den = 155.4701;
% FF_X_num = [1.0000, 30.7397, 44.3915];
% 
% FF_Z_den = 165.5945;
% FF_Z_num = [1.0000, 46.2319, 11.1400];

% Model trained on both WN and MS
FF_R_den = 138.2018;
FF_R_num = [1.0000, 18.4292, 22.3640];

FF_X_den = 126.3693;
FF_X_num = [1.0000, 22.8298, 30.9368];

FF_Z_den = 12.3458;
FF_Z_num = [1.0000, 3.5412, 2.4414];
