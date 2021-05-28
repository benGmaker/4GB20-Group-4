clc; %close all;
load('WN_10sec_RXZ_IO.mat') % This one works fine
% load('WN_10sec_RXZ_indiv_IO.mat') % This one works fine as well (probably better)
% load('WN_10sec_RXZ_1hz_sine_lowampWN.mat') % This one needs some work

%% Read output
out_R_dat = out_R.data;
out_X_dat = out_X.data;
out_Z_dat = out_Z.data;

%% TF-estimate
nfft = 1024;
[H_R, f_R] = tfestimate(R', out_R_dat, hann(nfft), [], nfft, fs);
[H_X, f_X] = tfestimate(X', out_X_dat, hann(nfft), [], nfft, fs);
[H_Z, f_Z] = tfestimate(Z', out_Z_dat, hann(nfft), [], nfft, fs);

phase_R = rad2deg(angle(H_R));
phase_X = rad2deg(angle(H_X));
phase_Z = rad2deg(angle(H_Z));

%% Wrap phase
% for i = 1:length(phase_R)-1
%     if phase_R(i+1) - phase_R(i) >= 300
%         phase_R(i+1:end) = phase_R(i+1:end) - 360;
%     elseif phase_R(i+1) - phase_R(i) <= -300
%         phase_R(i+1:end) = phase_R(i+1:end) + 360;
%     end
% end
% 
% for i = 1:length(phase_X)-1
%     if phase_X(i+1) - phase_X(i) >= 300
%         phase_X(i+1:end) = phase_X(i+1:end) - 360;
%     elseif phase_X(i+1) - phase_X(i) <= -300
%         phase_X(i+1:end) = phase_X(i+1:end) + 360;
%     end
% end
% 
% for i = 1:length(phase_Z)-1
%     if phase_Z(i+1) - phase_Z(i) >= 300
%         phase_Z(i+1:end) = phase_Z(i+1:end) - 360;
%     elseif phase_Z(i+1) - phase_Z(i) <= -300
%         phase_Z(i+1:end) = phase_Z(i+1:end) + 360;
%     end
% end

%% Manual bode plot
figure()
tiledlayout(2,3)
nexttile;
semilogx(f_R*2*pi, 10*log10(abs(H_R)))
title('Manual bode R from tfestimate')
ylabel('Magnitude [dB]')
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_X*2*pi, 10*log10(abs(H_X)))
title('Manual bode X from tfestimate')
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_Z*2*pi, 10*log10(abs(H_Z)))
title('Manual bode Z from tfestimate')
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_R*2*pi, phase_R)
hold on
plot(linspace(1e1,1e4,length(f_R)),linspace(-180,-180,length(f_R)))
xlabel('Frequency [rad/s]')
ylabel('Phase [deg]')
ylim([-180,180])
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_X*2*pi, phase_X)
hold on
plot(linspace(1e1,1e4,length(f_X)),linspace(-180,-180,length(f_X)))
xlabel('Frequency [rad/s]')
ylim([-180,180])
xlim([1e1,1e4])
grid on

nexttile;
semilogx(f_Z*2*pi, phase_Z)
hold on
plot(linspace(1e1,1e4,length(f_Z)),linspace(-180,-180,length(f_Z)))
xlabel('Frequency [rad/s]')
ylim([-180,180])
xlim([1e1,1e4])
grid on