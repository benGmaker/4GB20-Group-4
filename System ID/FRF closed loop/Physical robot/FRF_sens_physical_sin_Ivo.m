clc; %close all;
dis_R = load('dis_sin_R.mat');
meas_R = load('meas_sin_R.mat');

%% Read output
meas_R_dat = meas_R.ans(2,:);

dis_R_dat = dis_R.ans(2,:);


%% TF-estimate
fs = 4096;
nfft = 1024;
[S_R, f_R] = tfestimate(dis_R_dat, meas_R_dat, hann(nfft), [], nfft, fs);


H_R = 1./S_R - 1;

phase_S_R = rad2deg(angle(S_R));


phase_R = rad2deg(angle(H_R));


[C_R, fC_R] = mscohere(dis_R_dat, meas_R_dat, hann(nfft), [], nfft, fs);


%% Manual bode plot Sensitivity
figure()
tiledlayout(2,1)
nexttile;
semilogx(f_R*2*pi, 10*log10(abs(S_R)))
title('Sensitivity R')
ylabel('Magnitude [dB]')
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



%% Manual bode plot Open loop
figure()
tiledlayout(2,1)
nexttile;
semilogx(f_R*2*pi, 10*log10(abs(H_R)))
title('Open loop R')
ylabel('Magnitude [dB]')
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




%% Coherence
figure()

nexttile;
plot(fC_R*2*pi, C_R)
title('Coherence R')
xlabel('Frequeny [rad/s]')
grid on

