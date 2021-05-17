close all; clc;

%% Load data
load('Group_04_test_16_19.mat');

time = data(1,:);
R = data(2,:);
X = data(3,:);
Z = data(4,:);

%% 
figure(1)
plot(time, R, time, X, time, Z)
legend('R', 'X', 'Z')
grid on

%% 'Zero' positions after homing (E-box)
Ebox_zero_R = 487;
Ebox_zero_X = -39561;
Ebox_zero_Z = -2436;

%% Measured angles 'zero' position after homing (From measurement)
zero_R = -0.000754; % rad
zero_X = 0.01202;   % rad
zero_Z = -0.007069; % rad

%% Alternative positions (E-box)
Ebox_alt_R = 5668;      % steps
Ebox_alt_X = -43033;    % steps
Ebox_alt_Z = 989;       % steps

%% Measured angles alternative position (From measurement)
alt_R = 0.4867; % rad
alt_X = 0.4985; % rad
alt_Z = 0.4784; % rad

%% E-box relations
rad_step_R = (alt_R - zero_R)/(Ebox_alt_R - Ebox_zero_R);
rad_step_X = (alt_X - zero_X)/(Ebox_alt_X - Ebox_zero_X);
rad_step_Z = (alt_Z - zero_Z)/(Ebox_alt_Z - Ebox_zero_Z);

%% Center calibraition hole positions (E-box)
Ebox_calib_R = 3176;    % steps
Ebox_calib_X = -42277;  % steps
Ebox_calib_Z = -5728;   % steps

%% Actual angles center calibration hole (FROM IK)
actual_calib_R = 0;
actual_calib_X = 1.147615161297590;
actual_calib_Z = -0.211769005130479;

%% Derived angles center calibration hole (from E-box to angle relation)
calib_R = rad_step_R*(Ebox_calib_R - Ebox_zero_R) + zero_R;
calib_X = rad_step_X*(Ebox_calib_X - Ebox_zero_X) + zero_X;
calib_Z = rad_step_Z*(Ebox_calib_Z - Ebox_zero_Z) + zero_Z;

%% Offset calculation
offset_R = actual_calib_R - calib_R;
offset_X = actual_calib_X - calib_X;
offset_Z = actual_calib_Z - calib_Z;


