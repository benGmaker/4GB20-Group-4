clc; 
% load('FRF_RXZ.mat');

%% Contoller
% s = tf('s');
s = 1i*f_R*2*pi;

c_R = 1/(1 + .01*s);

CP_R = c_R'.*H_R;

%% Visualize
phase_R = rad2deg(angle(c_R'));
% phase_X = rad2deg(angle(CP_X));
% phase_Z = rad2deg(angle(CP_Z));

mag_R = db(abs(c_R'));
% mag_X = db(abs(CP_X));
% mag_Z = db(abs(CP_Z));

%% Figure
figure()
tiledlayout(2,1);

nexttile;
semilogx(f_R, mag_R)
title('Open loop R')
ylabel('Magnitude [dB]')
xlim([f_R(1), f_R(end)])
grid on

nexttile;
semilogx(f_R, phase_R)
xlabel('Frequency [Hz]')
ylabel('Phase [deg]')
ylim([-200,200])
xlim([f_R(1), f_R(end)])
grid on


