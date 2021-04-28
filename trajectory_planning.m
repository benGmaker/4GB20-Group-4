clear all; close all; clc;
%% Load IK equations
% global IK 
IK = load("eqn_IK_robotarm.mat");


%% TEMPORARY TRAJECTORY
r = linspace(250, 170, 100);
z = linspace(6, 120, 100);
t = 1:100;

tic
[Rx,Rz] = fcn_IK(r, z, IK)
toc

%%
r = 250;
z = 6;

tic
[Rx, Rz] = fcn_IK(r,z,IK)
toc