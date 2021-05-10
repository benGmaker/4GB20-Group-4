clear all; close all; clc
%% Load data
addpath('D:\Files\OneDrive - TU Eindhoven\03 Education\01 Courses\4GB20 Robot Arm\Github\4GB20-Group-4\robotarm_sim')

load('dat_io_MS.mat');
load('dat_io_S20.mat');
load('dat_io_WN.mat');

fs = 2048;
Ts = 1/fs;
%% Superimposing WN and MS
dat_ref_R = dat_ref_R_MS + dat_ref_R_WN;
dat_ref_X = dat_ref_X_MS + dat_ref_X_WN;
dat_ref_Z = dat_ref_Z_MS + dat_ref_Z_WN;

dat_out_R = dat_out_R_MS + dat_out_R_WN;
dat_out_X = dat_out_X_MS + dat_out_X_WN;
dat_out_Z = dat_out_Z_MS + dat_out_Z_WN;

dat_R = iddata(dat_out_R, dat_ref_R, Ts);
dat_X = iddata(dat_out_X, dat_ref_X, Ts);
dat_Z = iddata(dat_out_Z, dat_ref_Z, Ts);

%% Train model on superimposed dataset
tf_mat_R = tfest(dat_R, 2, 0);
tf_mat_X = tfest(dat_X, 2, 0);
tf_mat_Z = tfest(dat_Z, 2 ,0);
%% Compare with Multisine input
figure(1)
compare(dat_R_MS, tf_mat_R)
title("R data")

figure(2)
compare(dat_X_MS, tf_mat_X)
title("X data")

figure(3)
compare(dat_Z_MS, tf_mat_Z)
title("Z data")

%% Compare with 20 Hz sine input
figure(1)
compare(dat_R_S20, tf_mat_R)
title("R data")

figure(2)
compare(dat_X_S20, tf_mat_X)
title("X data")

figure(3)
compare(dat_Z_S20, tf_mat_Z)
title("Z data")

%% Compare with white noise input
figure(1)
compare(dat_R_WN, tf_mat_R)
title("R data")

figure(2)
compare(dat_X_WN, tf_mat_X)
title("X data")

figure(3)
compare(dat_Z_WN, tf_mat_Z)
title("Z data")











%% Fourier transform
% fs = 2048;
% Ts = 1/fs;
% L = length(dat_ref_R_S20);
% 
% U_S20_R = fft(dat_ref_R_S20);
% U_S20_X = fft(dat_ref_X_S20);
% U_S20_Z = fft(dat_ref_Z_S20);
% 
% Y_S20_R = fft(dat_out_R_S20);
% Y_S20_X = fft(dat_out_X_S20);
% Y_S20_Z = fft(dat_out_Z_S20);
% 
% U_MS_R = fft(dat_ref_R_MS);
% U_MS_X = fft(dat_ref_X_MS);
% U_MS_Z = fft(dat_ref_Z_MS);
% 
% Y_MS_R = fft(dat_out_R_MS);
% Y_MS_X = fft(dat_out_X_MS);
% Y_MS_Z = fft(dat_out_Z_MS);

%% FRF
% pwelch(dat_out_R_MS)
% cpsd(dat_ref_R_MS, dat_out_R_MS)
% figure(1)
% tfestimate(dat_ref_R_MS, dat_out_R_MS, hann((L-1)/4), 256, (L-1)/4, fs);
% 
% [H,hz] = tfestimate(dat_ref_R_MS, dat_out_R_MS, hann((L-1)/4), 256, (L-1)/4, fs);
% 
% figure(2)
% tiledlayout(2,1);
% ax1 = nexttile;
% semilogx(ax1, hz, abs(H))
% title(ax1, "Magnitude")
% ylabel(ax1, 'Magnitude (dB)')
% 
% ax2 = nexttile;
% semilogx(ax2, hz, angle(H)*180/2/pi)
% title(ax2, "Phase")
% ylabel(ax2, 'Phase (deg)')

%%
% tfestimate(dat_ref_X_MS, dat_out_X_MS, hann((L-1)/4), 256, (L-1)/4, fs);
% tfestimate(dat_ref_Z_MS, dat_out_Z_MS, hann((L-1)/4), 256, (L-1)/4, fs);

% figure(3)
% tfestimate(dat_ref_R_S20, dat_out_R_S20, hann((L-1)/8), [], (L-1)/8, fs)


% window = hann(L/8);
% modalfrf(dat_ref_R_MS, dat_out_R_MS, fs, window)
