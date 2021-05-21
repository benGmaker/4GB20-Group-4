clc; close all;
load('WN_10sec_RXZ_IO.mat')

%% Read output
out_R_dat = out_R.data;
out_X_dat = out_X.data;
out_Z_dat = out_Z.data;

%% PSD [Not necessary]
% window = 1024
% [pRR,f_R] = pwelch(out_R_dat, 1024, window/2);
% 
% figure(1)
% semilogx(f_R/max(f_R),10*log10(pRR))
% xlabel('Frequency (kHz)')
% ylabel('PSD (dB/Hz)')

%% TF-estimate
nfft = 1024;
[H_R, f_R] = tfestimate(R', out_R_dat, hann(nfft), [], nfft, fs);
[H_X, f_X] = tfestimate(X', out_X_dat, hann(nfft), [], nfft, fs);
[H_Z, f_Z] = tfestimate(Z', out_Z_dat, hann(nfft), [], nfft, fs);

phase_R = rad2deg(angle(H_R));
phase_X = rad2deg(angle(H_X));
phase_Z = rad2deg(angle(H_Z));

for i = 1:length(phase_R)-1
    if phase_R(i+1) - phase_R(i) >= 300
        phase_R(i+1:end) = phase_R(i+1:end) - 360;
    elseif phase_R(i+1) - phase_R(i) <= -300
        phase_R(i+1:end) = phase_R(i+1:end) + 360;
    end
        
        
end

%% Automatic figure
% figure()
% tfestimate(R', out_R_dat, hann(nfft), [], nfft, fs);
% figure()
% tfestimate(X', out_X_dat, hann(nfft), [], nfft, fs);
% figure()
% tfestimate(Z', out_Z_dat, hann(nfft), [], nfft, fs);

%% Manual bode plot
figure()
tiledlayout(2,1)
nexttile;
semilogx(f_R*2*pi, 10*log10(abs(H_R)))
title('Manual bode from tfestimate')
ylabel('Magnitude [dB]')
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_R*2*pi, phase_R)
xlabel('Frequency [rad/s]')
ylabel('Phase [deg]')
ylim([-360,0])
xlim([1e1,1e4])

grid on

% line([0,1e4], [-180,-180], 'linestyle', '--')



