clear all; close all; clc
%% Load calibration data
% load('calib_Ivo_1029.mat');
% 
% time = data(1,:);
% out_R = data(2,:);
% out_X = data(3,:);
% out_Z = data(4,:);

%%
% figure(1)
% plot(time,out_R); hold on
% plot(time,out_X)
% plot(time,out_Z)


%% Perceived angles at "Zero"
R_zero = 0;
X_zero = 0;
Z_zero = -0.010037388528219;

%% Ebox steps at "Zero"
R_e_zero = 613;
X_e_zero = 8078;
Z_e_zero = -4553;

%% Ebox steps at calibration hole
R_e_calib = 1145;
X_e_calib = 5631;
Z_e_calib = -6940;

%% Relation between steps and angle
R_steps_rad = 4000*150/9/2/pi;
X_steps_rad = 4000*100/9/2/pi;
Z_steps_rad = 4000*100/9/2/pi;

%% Derived percieved angles at calibration hole
R_calib = 1/R_steps_rad*(R_e_calib - R_e_zero) + R_zero;
X_calib = -1/X_steps_rad*(X_e_calib - X_e_zero) + X_zero;
Z_calib = 1/Z_steps_rad*(Z_e_calib - Z_e_zero) + Z_zero;

%% Angles at calibration hole from IK
R_calib_IK = 0;
X_calib_IK = 1.10907;
Z_calib_IK = -0.28397;

%% Calculate offsets
R_offset = R_calib_IK - R_calib;
X_offset = X_calib_IK - X_calib;
Z_offset = Z_calib_IK - Z_calib;



