addpath(genpath("..\..\4GB20-Group-4"))
%% General script that runs the robot arm
fs = 2048; % Simulation frequency
% fs = 4096; % Real-world frequency

ticsX=-2771;        % Difference in tics between calibration holes
ticsZ=-2102;
ticsR=0;

IK = load("eqn_IK_robotarm.mat");
z_pickup = 24;      % Pickup height of the bolts
z_moving = 50;      % Safe moving height over the bolts, even with bolt clamped

%% Calibration
% This needs to be taken over by calibration
r_init = 200;       % Initial r of the EE
theta_init = 0;     % Initial theta of the EE
z_init = 60;        % Initial z of the EE

%% Load the GUI
run('GUI.mlapp')
disp(sprintf("First select the desired positions in the GUI (pop-up) and click confirm. \nNext select the Command Window and press any key."))
pause()

%% Calibration
% This needs to be automatically adjusted by calibration.
% [alpha,beta]=calibrationalphabeta(ticsX,ticsZ,ticsR);

% for sim this is the case
alpha = 90; 
beta = 0;

%% GUI conversion to cylindrical coordinate frame
[r_s,theta_s] = distance_and_angle(source, 'source', alpha, beta);
[r_p,theta_p] = distance_and_angle(print, 'print', alpha, beta);
theta_s = deg2rad(theta_s);
theta_p = deg2rad(theta_p);

r = [r_s',r_p'];
%r=[r_s(3) r_s(4) r_s(1) r_s(2) r_p(2) r_p(4) r_p(1) r_p(3)];
phiR = [theta_s',theta_p'];
%phiR=[theta_s(3) theta_s(4) theta_s(1) theta_s(2) theta_p(2) theta_p(4) theta_p(1) theta_p(3)];
z=z_pickup*ones(1,length(r));


%% IK 
for j=1:length(r)
    posArray(j) = ArmPos;
    posArray(j).D = [r(j),z(j)];
    posArray(j) = posArray(j).DtoC();
    posArray(j) = KineMod.IK_MAU(posArray(j).C,false);
end

for i=1:length(posArray)
    phiX(i) = 1/2*pi-posArray(i).phiX;
    phiZ(i) = posArray(i).phiZ;
end

Motorangles=[phiR;phiX;phiZ];

%% ---------------
%% Experiment data
%% ---------------
%load('SSA9_1457.mat')
load('SSA10_try1.mat')
t = ans(1,:);
R = ans(2,:);
X = ans(3,:);
Z = ans(4,:);

%% Bolt times
t1 = 19;
t2 = 25;
t3 = 31;
t4 = 39;
t5 = 45;
t6 = 55;
t7 = 64;
t8 = 70;
t9 = 75;
t10 = 80;
t11 = 86;
t12 = 94;

R_bolts = [R((t1-14.5)*4096) R((t2-14.5)*4096) R((t3-14.5)*4096) R((t4-14.5)*4096) R((t5-14.5)*4096) R((t6-14.5)*4096) R((t7-14.5)*4096) R((t8-14.5)*4096) R((t9-14.5)*4096) R((t10-14.5)*4096) R((t11-14.5)*4096) R((t12-14.5)*4096)];
X_bolts = [X((t1-14.5)*4096) X((t2-14.5)*4096) X((t3-14.5)*4096) X((t4-14.5)*4096) X((t5-14.5)*4096) X((t6-14.5)*4096) X((t7-14.5)*4096) X((t8-14.5)*4096) X((t9-14.5)*4096) X((t10-14.5)*4096) X((t11-14.5)*4096) X((t12-14.5)*4096)];
Z_bolts = [Z((t1-14.5)*4096) Z((t2-14.5)*4096) Z((t3-14.5)*4096) Z((t4-14.5)*4096) Z((t5-14.5)*4096) Z((t6-14.5)*4096) Z((t7-14.5)*4096) Z((t8-14.5)*4096) Z((t9-14.5)*4096) Z((t10-14.5)*4096) Z((t11-14.5)*4096) Z((t12-14.5)*4096)];
bolts_RXZ = [R_bolts;X_bolts;Z_bolts];

%% Figure R
figure(1)
hold on
plot(1:length(r),0.04+bolts_RXZ(1,:))
plot(1:length(r),Motorangles(1,:))
legend('Exp','IK')
%% Figure X
figure(2)
hold on
plot(1:length(r),0.04+bolts_RXZ(2,:))
plot(1:length(r),Motorangles(2,:))
legend('Exp','IK')
%% Figure Z
figure(3)
hold on
plot(1:length(r),0.232+bolts_RXZ(3,:))
plot(1:length(r),Motorangles(3,:))
legend('Exp','IK')


