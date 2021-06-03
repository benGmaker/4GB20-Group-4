clear all; close all; clc

%% Perceived angles at "Zero" (position after homing)
R_zero = 9.4248*10^-5;
X_zero = 14.137*10^-5;
Z_zero = -0.01357168;

%% Ebox steps at "Zero" (position after homing)
R_e_zero = 31320;
X_e_zero = -24125;
Z_e_zero = -5070;

%% Ebox steps at calibration hole
R_e_calib = 32012;
X_e_calib = -26986;
Z_e_calib = -8302;

%% Relation between steps and angle
R_steps_rad = 4000*150/9/2/pi;
X_steps_rad = -4000*100/9/2/pi;
Z_steps_rad = 4000*100/9/2/pi;

%% Derived percieved angles at calibration hole
R_calib = 1/R_steps_rad*(R_e_calib - R_e_zero) + R_zero;
X_calib = 1/X_steps_rad*(X_e_calib - X_e_zero) + X_zero;
Z_calib = 1/Z_steps_rad*(Z_e_calib - Z_e_zero) + Z_zero;

%% Angles at calibration hole from IK (THESE ARE CURRENTLY INCORRECT)
R_calib_IK = 0;
X_calib_IK = 0.4257;
Z_calib_IK = -0.2167;

%% Calculate offsets
R_offset = R_calib_IK - R_calib
X_offset = X_calib_IK - X_calib
Z_offset = Z_calib_IK - Z_calib



