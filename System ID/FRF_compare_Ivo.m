clc; close all
%% Comparison
comp1 = 'WN_10sec_RXZ_indiv_IO.mat';
comp2 = 'WN_10sec_RXZ_IO.mat';

legend1 = 'WN indiv';
legend2 = 'WN togehter';

%% FRF
nfft = 1024;

% perform FRF for file 1
load(comp1) 
out_R_dat = out_R.data;
out_X_dat = out_X.data;
out_Z_dat = out_Z.data;

[magR1, phaR1, magX1, phaX1, magZ1, phaZ1, freq1] = fcn_FRF(R', out_R_dat, X', out_X_dat, Z', out_Z_dat, nfft, fs);

% perform FRF for file 2
load(comp2) 
out_R_dat = out_R.data;
out_X_dat = out_X.data;
out_Z_dat = out_Z.data;

[magR2, phaR2, magX2, phaX2, magZ2, phaZ2, freq2] = fcn_FRF(R', out_R_dat, X', out_X_dat, Z', out_Z_dat, nfft, fs);

%% Manual bode plot
figure()
tiledlayout(2,3)
nexttile;
semilogx(freq1, magR1, freq2, magR2)
title('Manual bode R from tfestimate')
ylabel('Magnitude [dB]')
legend(legend1, legend2)
xlim([1e1,1e4])
grid on

nexttile;
semilogx(freq1, magX1, freq2, magX2)
title('Manual bode X from tfestimate')
xlim([1e1,1e4])
legend(legend1, legend2)
grid on

nexttile;
semilogx(freq1, magZ1, freq2, magZ2)
title('Manual bode Z from tfestimate')
xlim([1e1,1e4])
legend(legend1, legend2)
grid on

nexttile;
semilogx(freq1, phaR1, freq2, phaR2)
hold on
plot(linspace(1e1,1e4,length(freq1)),linspace(-180,-180,length(freq1)))
xlabel('Frequency [rad/s]')
ylabel('Phase [deg]')
ylim([-360,0])
xlim([1e1,1e4])
grid on

nexttile;
semilogx(freq1, phaX1, freq2, phaX2)
hold on
plot(linspace(1e1,1e4,length(freq1)),linspace(-180,-180,length(freq1)))
xlabel('Frequency [rad/s]')
ylim([-360,0])
xlim([1e1,1e4])
grid on

nexttile;
semilogx(freq1, phaZ1, freq2, phaZ2)
hold on
plot(linspace(1e1,1e4,length(freq1)),linspace(-180,-180,length(freq1)))
xlabel('Frequency [rad/s]')
ylim([-360,0])
xlim([1e1,1e4])
grid on
