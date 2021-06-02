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
% run('GUI.mlapp')
% disp(sprintf("First select the desired positions in the GUI (pop-up) and click confirm. \nNext select the Command Window and press any key."))
% pause()
load('sourceprint1457.mat')

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

r=[r_p(2) r_p(4) r_p(1) r_p(3) r_s(3) r_s(4) r_s(1) r_s(2)];
phiR=[theta_p(2) theta_p(4) theta_p(1) theta_p(3) theta_s(3) theta_s(4) theta_s(1) theta_s(2)];
z=z_pickup*ones(1,8);


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
load('SSA9_1457.mat')
t = out_RXZ(1,:);
R = out_RXZ(2,:);
X = out_RXZ(3,:);
Z = out_RXZ(4,:);

figure()
hold on
plot(t,R)
plot(t,X)
plot(t,Z)
legend('R','X','Z')

%% Bolt times
t1 = 20;
t2 = 26;
t3 = 31;
t4 = 38;
t5 = 44;
t6 = 48;
t7 = 55;
t8 = 60;

R_bolts = [R(round(t1-15)*4096) R(round(t2-15)*4096) R(round(t3-15)*4096) R(round(t4-15)*4096) R(round(t5-15)*4096) R(round(t6-15)*4096) R(round(t7-15)*4096) R(round(t8-15)*4096)];
X_bolts = [X((t1-15)*4096) X((t2-15)*4096) X((t3-15)*4096) X((t4-15)*4096) X((t5-15)*4096) X((t6-15)*4096) X((t7-15)*4096) X((t8-15)*4096)];
Z_bolts = [Z((t1-15)*4096) Z((t2-15)*4096) Z((t3-15)*4096) Z((t4-15)*4096) Z((t5-15)*4096) Z((t6-15)*4096) Z((t7-15)*4096) Z((t8-15)*4096)];
bolts_RXZ = [R_bolts;X_bolts;Z_bolts];

%% Figure R
figure()
hold on
plot(1:8,0.3+0.6*bolts_RXZ(1,:)-0.7*(bolts_RXZ(1,:)-0.3).^2)
plot(1:8,Motorangles(1,:))
legend('Exp','IK')
%% Figure X
figure()
hold on
plot(1:8,0.75-(0.9-bolts_RXZ(2,:))/1.8)
plot(1:8,Motorangles(2,:))
legend('Exp','IK')
%% Figure Z
figure()
hold on
plot(1:8,1.5*bolts_RXZ(3,:)/1.4+0.2+0.5*(bolts_RXZ(3,:)).^2)
plot(1:8,Motorangles(3,:))
legend('Exp','IK')


