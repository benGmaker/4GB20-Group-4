% 1. Make sure to first run initRobotArm_p.m
% 2. Then run the simulation RobotArm.slx

%% Data preprocessing
dat_ref_R = ref_R.data - mean(ref_R.data);
dat_out_R = out_R.data - mean(out_R.data);
dat_R = iddata(dat_out_R, dat_ref_R, Ts);

%% FRF
% FR = spa(dat_R)%, [], fs);
% bode(FR)

%% Step response
% Mimp = impulseest(dat_R, 60)
% step(Mimp)

%% TF estimation
% tf_mat = tfest(dat_R, 2, 1)

compare(dat_R, tf_mat)
