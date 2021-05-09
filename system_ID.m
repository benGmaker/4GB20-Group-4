% 1. Make sure to first run initRobotArm_p.m
% 2. Then run the simulation RobotArm.slx

%% Data preprocessing
%dat_ref_R = ref_R.data - mean(ref_R.data);
%dat_out_R = out_R.data - mean(out_R.data);
%dat_R = iddata(dat_out_R, dat_ref_R, Ts);

dat_ref_X = ref_X.data - mean(ref_X.data);
dat_out_X = out_X.data - mean(out_X.data);
dat_X = iddata(dat_out_X, dat_ref_X, Ts);
%% FRF
% FR = spa(dat_R)%, [], fs);
% bode(FR)

%% Step response
% Mimp = impulseest(dat_R, 60)
%step(Mimp)

%% TF estimation
 tf_mat = tfest(dat_X, 2, 1)

compare(dat_X, tf_mat)

%% Create plots
% Nyquist
figure()
nyquist(tf_mat)
% xlim([-20 2])
% ylim([-20 20])


%Both the margins should be positive or phase margin should be greater than the gain margin.
% Bode
figure()
margin(tf_mat)
[Gm,Pm,Wcg,Wcp] = margin(tf_mat);

if Gm >= 2
   disp('Gain Margin is robust') 
end

% Stablity
G2_poles = pole(tf_mat)


% Robustness



% Impulse
figure()
impulse(tf_mat,90)