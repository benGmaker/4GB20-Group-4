clear all; close all; clc;
%% Load the GUI
run('GUI.mlapp')

disp(sprintf("First select the desired positions in the GUI (pop-up) and click confirm. \nNext select the Command Window and press any key."))
pause()

%% Settings
alpha = 10; % offset from the plate
beta = 0; % offset from center line of the plate (calibration line) (minus for offset to the source grid)

%% Find source position
[N_row, N_column] = find(source == 1);
N_column = 9+1-N_column;


% Calculation
r = sqrt((10*N_row+alpha).^2+(10*(N_column-1)+40-beta).^2)
theta = atand((10*N_row+alpha)/(10*N_column+40-beta));
theta = theta(:,1)

return
%% Find print position
[N_row, N_column] = find(print == 1);

% Calculation
r = sqrt((10*N_row+alpha).^2+(10*(N_column-1)+40+beta).^2)
theta = atand((10*N_row+alpha)/(10*N_column+40+beta)); 
theta = theta(:,1)


