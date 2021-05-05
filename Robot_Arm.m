% General script that runs the robot arm

clear all; close all; clc;
%% Load the GUI
run('GUI.mlapp')

disp(sprintf("First select the desired positions in the GUI (pop-up) and click confirm. \nNext select the Command Window and press any key."))
pause()

%% Settings
% This needs to be automatically adjusted by calibration.

alpha = 10; % offset from the plate
beta = 0; % offset from center line of the plate (calibration line) (minus for offset to the source grid)


%%
[r_s,theta_s] = distance_and_angle(source, 'source', alpha, beta)
[r_p,theta_p] = distance_and_angle(print, 'print', alpha, beta)
