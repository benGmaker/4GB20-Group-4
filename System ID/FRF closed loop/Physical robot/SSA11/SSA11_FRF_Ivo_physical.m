clc; %close all;
dis_R = load('dis_R.mat');
dis_X = load('dis_X.mat');
dis_Z = load('dis_Z.mat');
meas_R = load('meas_R.mat');
meas_X = load('meas_X.mat');
meas_Z = load('meas_Z.mat');

%% Read output
meas_R_dat = meas_R.ans(2,:);
meas_X_dat = meas_X.ans(2,:);
meas_Z_dat = meas_Z.ans(2,:);

dis_R_dat = dis_R.ans(2,:);
dis_X_dat = dis_X.ans(2,:);
dis_Z_dat = dis_Z.ans(2,:);

%% TF-estimate
fs = 4096;
nfft = 4096;
[S_R, f_R] = tfestimate(dis_R_dat, meas_R_dat, hann(nfft), [], nfft, fs);
[S_X, f_X] = tfestimate(dis_X_dat, meas_X_dat, hann(nfft), [], nfft, fs);
[S_Z, f_Z] = tfestimate(dis_Z_dat, meas_Z_dat, hann(nfft), [], nfft, fs);

H_R = 1./S_R - 1;
H_X = 1./S_X - 1;
H_Z = 1./S_Z - 1;

phase_S_R = rad2deg(angle(S_R));
phase_S_X = rad2deg(angle(S_X));
phase_S_Z = rad2deg(angle(S_Z));

phase_R = rad2deg(angle(H_R));
phase_X = rad2deg(angle(H_X));
phase_Z = rad2deg(angle(H_Z));

[C_R, fC_R] = mscohere(dis_R_dat, meas_R_dat, hann(nfft), [], nfft, fs);
[C_X, fC_X] = mscohere(dis_X_dat, meas_X_dat, hann(nfft), [], nfft, fs);
[C_Z, fC_Z] = mscohere(dis_Z_dat, meas_Z_dat, hann(nfft), [], nfft, fs);

%% Manual bode plot Sensitivity
figure()
tiledlayout(2,3)
nexttile;
semilogx(f_R, db(abs(S_R)))
title('Sensitivity R')
ylabel('Magnitude [dB]')
xlim([f_R(1), f_R(end)])
grid on

nexttile;
semilogx(f_X, db(abs(S_X)))
title('Sensitivity X')
xlim([f_R(1), f_R(end)])
grid on

nexttile;
semilogx(f_Z, db(abs(S_Z)))
title('Sensitivity Z')
xlim([f_R(1), f_R(end)])
grid on

nexttile;
semilogx(f_R, phase_S_R)
hold on
xlabel('Frequency [Hz]')
ylabel('Phase [deg]')
ylim([-200,200])
xlim([f_R(1), f_R(end)])
grid on

nexttile;
semilogx(f_X, phase_S_X)
hold on
xlabel('Frequency [Hz]')
ylim([-200,200])
xlim([f_R(1), f_R(end)])
grid on

nexttile;
semilogx(f_Z, phase_S_Z)
hold on
xlabel('Frequency [Hz]')
ylim([-200,200])
xlim([f_R(1), f_R(end)])
grid on

%% Manual bode plot Open loop
figure()
tiledlayout(2,3)
nexttile;
semilogx(f_R, db(abs(H_R)))
title('Open loop R')
ylabel('Magnitude [dB]')
xlim([f_R(1), f_R(end)])
grid on

nexttile;
semilogx(f_X, db(abs(H_X)))
title('Open loop X')
xlim([f_R(1), f_R(end)])
grid on

nexttile;
semilogx(f_Z, db(abs(H_Z)))
title('Open loop Z')
xlim([f_R(1), f_R(end)])
grid on

nexttile;
semilogx(f_R, phase_R)
hold on
xlabel('Frequency [Hz]')
ylabel('Phase [deg]')
ylim([-200,200])
xlim([f_R(1), f_R(end)])
grid on

nexttile;
semilogx(f_X, phase_X)
hold on
xlabel('Frequency [Hz]')
ylim([-200,200])
xlim([f_R(1), f_R(end)])
grid on

nexttile;
semilogx(f_Z, phase_Z)
hold on
xlabel('Frequency [Hz]')
ylim([-200,200])
xlim([f_R(1), f_R(end)])
grid on

%% Coherence
figure()
tiledlayout(1,3)
nexttile;
plot(fC_R, C_R)
title('Coherence R')
xlabel('Frequeny [Hz]')
ylim([0, 1.1])
grid on

nexttile;
plot(fC_X, C_X)
title('Coherence R')
xlabel('Frequeny [Hz]')
ylim([0, 1.1])
grid on

nexttile;
plot(fC_Z, C_Z)
title('Coherence R')
xlabel('Frequeny [Hz]')
ylim([0, 1.1])
grid on

