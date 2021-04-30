clear all; close all; clc;
%% Load the GUI
% run('GUI.mlapp')

%% Matrices
source = [zeros(14,9)];
print  = [zeros(14,9)];


source(14,9) = 1;
source(5,8) = 1;
source(10,3) = 1;
source
% print(12,6) = 1;
% print(9,2) = 1;
% print(6,6) = 1;
% print

% Settings
alpha = 10; % offset from the plate
beta = -5; % offset from center line of the plate (calibration line) (minus for offset to the source grid)


%% Find source position
[N_row, N_column] = find(source == 1);
N_row    = 14+1-N_row;
N_column = 9+1-N_column;


% Calculation
r = sqrt((10*N_row+alpha).^2+(10*(N_column-1)+40+beta).^2)

return
%% Find print position
[N_row, N_column] = find(print == 1);
N_row    = 14+1-N_row;


% Calculation
r = sqrt((10*N_row+alpha).^2+(10*(N_column-1)+40-beta).^2)

