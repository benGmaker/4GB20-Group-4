clc; %close all;
dis_R = load('dis_R_1.mat');
dis_X = load('dis_X_1.mat');
dis_Z = load('dis_Z_1.mat');
meas_R = load('meas_R_1.mat');
meas_X = load('meas_X_1.mat');
meas_Z = load('meas_Z_1.mat');

%% Read output
meas_R_dat = meas_R.ans(2,:);
meas_X_dat = meas_X.ans(2,:);
meas_Z_dat = meas_Z.ans(2,:);

dis_R_dat = dis_R.ans(2,:);
dis_X_dat = dis_X.ans(2,:);
dis_Z_dat = dis_Z.ans(2,:);

%% TF-estimate
fs = 4096;
nfft = 1024;
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
semilogx(f_R*2*pi, 10*log10(abs(S_R)))
title('Sensitivity R')
ylabel('Magnitude [dB]')
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_X*2*pi, 10*log10(abs(S_X)))
title('Sensitivity X')
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_Z*2*pi, 10*log10(abs(S_Z)))
title('Sensitivity Z')
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_R*2*pi, phase_S_R)
hold on
plot(linspace(1e1,1e4,length(f_R)),linspace(-180,-180,length(f_R)))
xlabel('Frequency [rad/s]')
ylabel('Phase [deg]')
ylim([-200,200])
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_X*2*pi, phase_S_X)
hold on
plot(linspace(1e1,1e4,length(f_X)),linspace(-180,-180,length(f_X)))
xlabel('Frequency [rad/s]')
ylim([-200,200])
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_Z*2*pi, phase_S_Z)
hold on
plot(linspace(1e1,1e4,length(f_Z)),linspace(-180,-180,length(f_Z)))
xlabel('Frequency [rad/s]')
ylim([-200,200])
xlim([1e1,1e4])
grid on

%% Manual bode plot Open loop
figure()
tiledlayout(2,3)
nexttile;
semilogx(f_R*2*pi, 10*log10(abs(H_R)))
title('Open loop R')
ylabel('Magnitude [dB]')
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_X*2*pi, 10*log10(abs(H_X)))
title('Open loop X')
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_Z*2*pi, 10*log10(abs(H_Z)))
title('Open loop Z')
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_R*2*pi, phase_R)
hold on
plot(linspace(1e1,1e4,length(f_R)),linspace(-180,-180,length(f_R)))
xlabel('Frequency [rad/s]')
ylabel('Phase [deg]')
ylim([-200,200])
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_X*2*pi, phase_X)
hold on
plot(linspace(1e1,1e4,length(f_X)),linspace(-180,-180,length(f_X)))
xlabel('Frequency [rad/s]')
ylim([-200,200])
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_Z*2*pi, phase_Z)
hold on
plot(linspace(1e1,1e4,length(f_Z)),linspace(-180,-180,length(f_Z)))
xlabel('Frequency [rad/s]')
ylim([-200,200])
xlim([1e1,1e4])
grid on

%% Coherence
figure()
tiledlayout(1,3)
nexttile;
plot(fC_R*2*pi, C_R)
title('Coherence R')
xlabel('Frequeny [rad/s]')
ylim([0, 1.1])
grid on

nexttile;
plot(fC_X*2*pi, C_X)
title('Coherence R')
xlabel('Frequeny [rad/s]')
ylim([0, 1.1])
grid on

nexttile;
plot(fC_Z*2*pi, C_Z)
title('Coherence R')
xlabel('Frequeny [rad/s]')
ylim([0, 1.1])
grid on

grid on
