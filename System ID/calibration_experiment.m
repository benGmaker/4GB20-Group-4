clc; %close all;
% load('WN_10sec_RXZ_IO.mat') % This one works fine
% load('WN_10sec_RXZ_indiv_IO.mat') % This one works fine as well (probably better)
% load('WN_10sec_RXZ_1hz_sine_lowampWN.mat') % This one needs some work

%% Load data
%load('SSA9_1457.mat')
load('SSA10_try1.mat')
t = ans(1,:);
R = ans(2,:);
X = ans(3,:);
Z = ans(4,:);

%% Plots
figure()
hold on
plot(t,R);
plot(t,X);
plot(t,Z);
legend('R','X','Z')

%% Bolt times
% t1 = 20;
% t2 = 26;
% t3 = 31;
% t4 = 38;
% t5 = 44;
% t6 = 48;
% t7 = 55;
% t8 = 60;
% t9 = 67;

%% Bolt times 2
t1 = 19;
t2 = 25;
t3 = 31;
t4 = 39;
t5 = 45;
t6 = 55;
t7 = 64;
t8 = 70;
t9 = 75;
t10 = 70;
t11 = 86;
t12 = 94;

%% Bolt positions

R_bolts = [R((t1-14.5)*4096) R((t2-14.5)*4096) R((t3-14.5)*4096) R((t4-14.5)*4096) R((t5-14.5)*4096) R((t6-14.5)*4096) R((t7-14.5)*4096) R((t8-14.5)*4096) R((t9-14.5)*4096) R((t10-14.5)*4096) R((t11-14.5)*4096) R((t12-14.5)*4096)];
X_bolts = [X((t1-14.5)*4096) X((t2-14.5)*4096) X((t3-14.5)*4096) X((t4-14.5)*4096) X((t5-14.5)*4096) X((t6-14.5)*4096) X((t7-14.5)*4096) X((t8-14.5)*4096) X((t9-14.5)*4096) X((t10-14.5)*4096) X((t11-14.5)*4096) X((t12-14.5)*4096)];
Z_bolts = [Z((t1-14.5)*4096) Z((t2-14.5)*4096) Z((t3-14.5)*4096) Z((t4-14.5)*4096) Z((t5-14.5)*4096) Z((t6-14.5)*4096) Z((t7-14.5)*4096) Z((t8-14.5)*4096) Z((t9-14.5)*4096) Z((t10-14.5)*4096) Z((t11-14.5)*4096) Z((t12-14.5)*4096)];
bolts_RXZ = [R_bolts;X_bolts;Z_bolts];