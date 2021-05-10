clc; close all;
% t = linspace(0, 100);                                 % Time Vector (0 - 10ms)
% f = 10/max(t);                                           % Desired Frequency (Cycles/Timespan)
% sqwv = sign(sin(2*pi*t*f));                             % Signal
% figure
% plot(t, sqwv, 'LineWidth',1.5)
% grid
% ylim(ylim*1.1)
% xlabel('Time (s)')
% ylabel('Amplitude')


%% Initialize robotarm
fs = 2048;
Ts = 1/fs;

%% Trajectory
% Time vector
t_sim = 100;    % [s] Simulation duration (SHOULD BE EQUAL TO VALUE IN SIMULINK)
n = t_sim*fs;   % [-] Number of samples (based on sampling frequency)

t = 0:t_sim/n:t_sim;
f = fs/max(t);

% Example Trajectory for R, X, and Z (To be run with feedback)
% R = linspace(-pi/4, pi/4,   n+1);
% X = linspace(0.1,   1.2,    n+1);
% Z = linspace(-0.3,  0.2,    n+1);

% Sine sweep for system identification
% R = 0.3*chirp(t, 0.1, t(end), 200); % Sine sweep
% R = sin(2*pi*20*t);                 % Just a sine for validation
R = sign(sin(2*pi*t*f/40));
% R = frest.createStep('StepTime',1,'StepSize',0.1,'FinalTime',1.5);


plot(t, R)




