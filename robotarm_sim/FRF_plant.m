figure()
%% Loading files for R
clc; close all;

run('initRobotArm_p.m')
load('R_input.mat')
load('R_output.mat')

nfft = fs*2

N = length(input_R)
M=N+1;
window = hann(nfft);
% window = hann(N/50);

% Transfer function estimation
[tf,F] = tfestimate(input_R(2,:),output_R(2,:),window,[],nfft,fs)

set(gcf,'units','points','position',[10,10,700,500]);
subplot(2,3,1)
grid on
semilogx(F,mag2db(abs(tf)),'LineWidth',1)
xlabel('Frequency (rad s^{-1})');
ylabel('Magnitude (dB)');
hold on
title('Bode plot for FRF of R axis')
subplot(2,3,4)

grid on
semilogx(F,rad2deg(angle(tf)),'LineWidth',1)
xlabel('Frequency (rad s^{-1})');
ylabel('Phase angle of R ({\circ})');
title('Phase plot for FRF R axis')
hold on

%% Loading files for X

run('initRobotArm_p.m')
load('X_input.mat')
load('X_output.mat')

nfft = fs*2

N = length(input_X)
M=N+1;
window = hann(nfft);
% window = hann(N/50);

% Transfer function estimation
[tf,F] = tfestimate(input_X(2,:),output_X(2,:),window,[],nfft,fs)

set(gcf,'units','points','position',[10,10,700,500]);
subplot(2,3,2)
grid on
semilogx(F,mag2db(abs(tf)),'LineWidth',1)
xlabel('Frequency (rad s^{-1})');
ylabel('Magnitude (dB)');
hold on
title('Bode plot for FRF of X axis')
subplot(2,3,5)

grid on
semilogx(F,rad2deg(angle(tf)),'LineWidth',1)
xlabel('Frequency (rad s^{-1})');
ylabel('Phase angle of X ({\circ})');
title('Phase plot for FRF X axis')
hold on

%% Loading files for Z

run('initRobotArm_p.m')
load('Z_input.mat')
load('Z_output.mat')

nfft = fs*2

N = length(input_Z)
M=N+1;
window = hann(nfft);
% window = hann(N/50);

% Transfer function estimation
[tf,F] = tfestimate(input_Z(2,:),output_Z(2,:),window,[],nfft,fs)

set(gcf,'units','points','position',[10,10,700,500]);
subplot(2,3,3)
grid on
semilogx(F,mag2db(abs(tf)),'LineWidth',1)
xlabel('Frequency (rad s^{-1})');
ylabel('Magnitude (dB)');
hold on
title('Bode plot for FRF of Z axis')
subplot(2,3,6)

grid on
semilogx(F,rad2deg(angle(tf)),'LineWidth',1)
xlabel('Frequency (rad s^{-1})');
ylabel('Phase angle of R ({\circ})');
title('Phase plot for FRF Z axis')
hold on