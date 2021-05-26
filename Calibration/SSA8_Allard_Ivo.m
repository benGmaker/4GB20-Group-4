clc;

%%
step_per_rad_R = 1000*105/9/2/pi;
step_per_rad_X = 1000*100/9/2/pi;
step_per_rad_Z = 1000*100/9/2/pi;

%% Ebox values at 'Zero' position
Ebox_zero_R = -18068;
Ebox_zero_Z = -4474;
Ebox_zero_X = 37454;

%% Ebox values as calibration hole
Ebox_cali_R = 0; % TBD
Ebox_cali_Z = 0; % TBD
Ebox_cali_X = 0; % TBD

%% Measured angle at 'Zero' position
meas_zero_R = 0;
meas_zero_X = 0;
meas_zero_Z = -0.066020569615190;

%% Derive measured angle at calibration hole
meas_cali_R = meas_zero_R + 1/step_per_rad_R * (Ebox_cali_R - Ebox_zero_R); % rad
meas_cali_X = meas_zero_X + 1/step_per_rad_X * (Ebox_cali_X - Ebox_zero_X);
meas_cali_Z = meas_zero_Z + 1/step_per_rad_Z * (Ebox_cali_Z - Ebox_zero_Z);


%% Calculated angles center calibration hole (FROM IK)
actual_calib_R = 0;
actual_calib_X = 1.147615161297590;
actual_calib_Z = -0.211769005130479;

%% Offset is difference between measured and calculated angle
offset_R = actual_calib_R - meas_cali_R;
offset_X = actual_calib_X - meas_cali_X;
offset_Z = actual_calib_Z - meas_cali_Z;

%%
% data = load('SSA8_AI_1139.mat').ans;
%%
% plot(data(1,:),data(2,:)); hold on
% plot(data(1,:),data(3,:))
% plot(data(1,:),data(4,:))
% legend('R', 'X', 'Z')
% grid on

%% Prepre data file for FRF
fs = 2048;
Ts = 1/fs;

t_sim = 10;     % [s] Simulation duration (SHOULD BE EQUAL TO VALUE IN SIMULINK)
n = t_sim*fs;   % [-] Number of samples (based on sampling frequency)
t = 0:Ts:t_sim;

R = randn(1, n+1);
X = randn(1, n+1);
Z = randn(1, n+1);

% Turn into timeseries for Simulink
ref_R = timeseries(R',t);
ref_X = timeseries(X',t);
ref_Z = timeseries(Z',t);

% Save to file for Sim
save('reference_WN_R', 'ref_R');
save('reference_WN_X', 'ref_X');
save('reference_WN_Z', 'ref_Z');





