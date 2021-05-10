% 1. Make sure to first run initRobotArm_p.m
% 2. Then run the simulation RobotArm.slx

%% Data preprocessing
dat_ref_R = ref_R.data - mean(ref_R.data);
dat_out_R = out_R.data - mean(out_R.data);
dat_R = iddata(dat_out_R, dat_ref_R, Ts);

dat_ref_X = ref_X.data - mean(ref_X.data);
dat_out_X = out_X.data - mean(out_X.data);
dat_X = iddata(dat_out_X, dat_ref_X, Ts);

dat_ref_Z = ref_Z.data - mean(ref_Z.data);
dat_out_Z = out_Z.data - mean(out_Z.data);
dat_Z = iddata(dat_out_Z, dat_ref_Z, Ts);

% addpath('D:\Files\OneDrive - TU Eindhoven\03 Education\01 Courses\4GB20 Robot Arm\Github\4GB20-Group-4\robotarm_sim')
load('dat_io_S20.mat')
load('dat_io_MS.mat')

%% FRF
% FR = spa(dat_R)%, [], fs);
% bode(FR)

%% Step response
% Mimp = impulseest(dat_R, 60)
% step(Mimp)

%% TF estimation
tf_mat_R = tfest(dat_R, 2, 0);
tf_mat_X = tfest(dat_X, 2, 0);
tf_mat_Z = tfest(dat_Z, 2 ,0);

%%
figure(1)
compare(dat_R_MS, tf_mat_R)
title("R data")

figure(2)
compare(dat_X_MS, tf_mat_X)
title("X data")

figure(3)
compare(dat_Z_MS, tf_mat_Z)
title("Z data")

%%
figure(1)
compare(dat_R_S20, tf_mat_R)
title("R data")

figure(2)
compare(dat_X_S20, tf_mat_X)
title("X data")

figure(3)
compare(dat_Z_S20, tf_mat_Z)
title("Z data")
