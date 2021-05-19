% 1. Make sure to first run initRobotArm_p.m
% 2. Then run the simulation RobotArm.slx
clc; close all;
%<<<<<<< Updated upstream
% %% Data preprocessing
% dat_ref_R = ref_R.data - mean(ref_R.data);
% dat_out_R = out_R.data - mean(out_R.data);
% dat_R = iddata(dat_out_R, dat_ref_R, Ts);

% dat_ref_X = ref_X.data - mean(ref_X.data);
% dat_out_X = out_X.data - mean(out_X.data);
% dat_X = iddata(dat_out_X, dat_ref_X, Ts);

%=======
%% Data preprocessing
% dat_ref_R = ref_R.data - mean(ref_R.data);
% dat_out_R = out_R.data - mean(out_R.data);
% dat_R = iddata(dat_out_R, dat_ref_R, Ts);

% dat_ref_X = ref_X.data - mean(ref_X.data);
%  dat_out_X = out_X.data - mean(out_X.data);
%  dat_X = iddata(dat_out_X, dat_ref_X, Ts);
%>>>>>>> Stashed changes
% 
% dat_ref_Z = ref_Z.data - mean(ref_Z.data);
% dat_out_Z = out_Z.data - mean(out_Z.data);
% dat_Z = iddata(dat_out_Z, dat_ref_Z, Ts);
%% FRF
% FR_R = spa(dat_R)%, [], fs);
% bode(FR_R)

% FR_X = spa(dat_X)%, [], fs);
% bode(FR_X)

% FR_Z = spa(dat_Z)%, [], fs);
% bode(FR_Z)

%% Step response
% Mimp_R = impulseest(dat_R, 60)
% step(Mimp_R)

% Mimp_X = impulseest(dat_X, 60)
%step(Mimp_X)

% Mimp_Z = impulseest(dat_Z, 60)
%step(Mimp_Z)

%% TF estimation
%<<<<<<< Updated upstream
% tf_mat_R = tfest(dat_R, 2, 1)
% compare(dat_R, tf_mat_R)

%  tf_mat_X = tfest(dat_X, 2, 1)
%=======
% tf_mat_R = tfest(dat_R, 2, 1)
% compare(dat_R, tf_mat_R)

% tf_mat_X = tfest(dat_X, 2, 1)
%>>>>>>> Stashed changes
% compare(dat_X, tf_mat_X)

% tf_mat_Z = tfest(dat_Z, 2, 1)
% compare(dat_Z, tf_mat_Z)

%% Create plots: R
%<<<<<<< Updated upstream
% % Nyquist
% figure()
% nyquist(tf_mat_R)
% % xlim([-20 2])
% % ylim([-20 20])
% 
% 
% 
% %Both the margins should be positive or phase margin should be greater than the gain margin.
% % Bode
% figure()
% margin(tf_mat_R)
% [Gm,Pm,Wcg,Wcp] = margin(tf_mat_R);
% 
% 
% % Stablity
% [G_poles] = pole(tf_mat_R);
% if G_poles <= 0
%    disp('Poles are stable') 
% else
%    disp('Poles are NOT stable')
% end
% 
% % Robustness
% if Pm >= 30
%    disp('Phase Margin is robust') 
% else
%     disp('Phase Margin is NOT robust')
% end
% 
% if Gm >= 2
%    disp('Gain Margin is robust') 
% else
%    disp('Gain Margin is NOT robust')
% end
% 
% if 1/Gm >= 0.5
%    disp('Modulus Margin is robust') 
% else
%    disp('Modulus Margin is NOT robust')
% end
% 
% 
% % Impulse
% % figure()
% % impulse(tf_mat_R,90)
%=======
% Nyquist
% figure()
% nyquist(tf_mat_R)
% xlim([-20 2])
% ylim([-20 20])


%Both the margins should be positive or phase margin should be greater than the gain margin.
% Bode
% figure()
% margin(tf_mat_R)
% [Gm,Pm,Wcg,Wcp] = margin(tf_mat_R);

% if Pm >= 30
%    disp('Phase Margin is robust') 
% else
%     disp('Phase Margin is NOT robust')
% end
% 
% if Gm >= 2
%    disp('Gain Margin is robust') 
% else
%    disp('Gain Margin is NOT robust')
% end
% 
% if 1/Gm >= 0.5
%    disp('Modulus Margin is robust') 
% else
%    disp('Modulus Margin is NOT robust')
% end



% Stablity
% G2_poles = pole(tf_mat_R)


% Robustness



% Impulse
% figure()
% impulse(tf_mat_R,90)

%>>>>>>> Stashed changes

%% Create plots: X
% % Nyquist
% figure()
% nyquist(tf_mat_X)
% % xlim([-20 2])
% % ylim([-20 20])
% 
%<<<<<<< Updated upstream
% 
% %Both the margins should be positive or phase margin should be greater than the gain margin.
% % Bode
% figure()
% margin(tf_mat_X)
% [Gm,Pm,Wcg,Wcp] = margin(tf_mat_X);
% 
% if Pm >= 30
%    disp('Phase Margin is robust') 
% else
%     disp('Phase Margin is NOT robust')
% end
% 
% if Gm >= 2
%    disp('Gain Margin is robust') 
% else
%    disp('Gain Margin is NOT robust')
% end
% 
% if 1/Gm >= 0.5
%    disp('Modulus Margin is robust') 
% else
%    disp('Modulus Margin is NOT robust')
% end
% 
% 
% 
% % Stablity
% G2_poles = pole(tf_mat_X)
% 
% 
% % Robustness
% 
% 
% 
% % Impulse
% figure()
% impulse(tf_mat_X,90)
%=======
%>>>>>>> Stashed changes
% 
% %Both the margins should be positive or phase margin should be greater than the gain margin.
% % Bode
% figure()
% margin(tf_mat_X)
% [Gm,Pm,Wcg,Wcp] = margin(tf_mat_X);
% 
% if Pm >= 30
%    disp('Phase Margin is robust') 
% else
%     disp('Phase Margin is NOT robust')
% end
% 
% if Gm >= 2
%    disp('Gain Margin is robust') 
% else
%    disp('Gain Margin is NOT robust')
% end
% 
% if 1/Gm >= 0.5
%    disp('Modulus Margin is robust') 
% else
%    disp('Modulus Margin is NOT robust')
% end
% 
% 
% 
% % Stablity
% G2_poles = pole(tf_mat_X)
% 
% 
% % Robustness
% 
% 
% 
% % Impulse
% figure()
% impulse(tf_mat_X,90)
% % 
% 
%% Create plots: Z
% % Nyquist
% figure()
% nyquist(tf_mat_Z)
% % xlim([-20 2])
% % ylim([-20 20])
% 
% 
% %Both the margins should be positive or phase margin should be greater than the gain margin.
% % Bode
% figure()
% margin(tf_mat_Z)
% [Gm,Pm,Wcg,Wcp] = margin(tf_mat_Z);
% 
% if Pm >= 30
%    disp('Phase Margin is robust') 
% else
%     disp('Phase Margin is NOT robust')
% end
% 
% if Gm >= 2
%    disp('Gain Margin is robust') 
% else
%    disp('Gain Margin is NOT robust')
% end
% 
% if 1/Gm >= 0.5
%    disp('Modulus Margin is robust') 
% else
%    disp('Modulus Margin is NOT robust')
% end
% 
% 
% 
% % Stablity
% G2_poles = pole(tf_mat_Z)
% 
% 
% % Robustness
% 
% 
% 
% % Impulse
% figure()
% impulse(tf_mat_Z,90)
% 

%% Controller optimalization
FF_R_num = [1.0000, 18.4292, 22.3640];
FF_R_den = 138.2018;

% !!!Only these numbers need to be changed!!!
C_R_num = [0.00009634, 0.009634];
C_R_den = [1];

F = tf(FF_R_num, FF_R_den);
G  = 1/F;
C = tf(C_R_num,C_R_den);

% Open loop
L = G*C;
figure()
bode(L)
title('Bode Diagram Open Loop')

figure()
bode(G)
title('Bode diagram of the plant')

figure()
bode(C)
title('Bode diagram of the controller')

[Gm,Pm,Wcg,Wcp] = margin(L);
margin(L)

S = 1/(1 + L);
figure()
bode(S)
title('Sensitivity')

% Stablity
[L_poles] = pole(L);
if L_poles <= 0
   disp('Poles are stable') 
else
   disp('Poles are NOT stable')
end

% Robustness
if Pm == Inf
   disp('Phase Margin is infinite') 
elseif Pm >= 30
   disp('Phase Margin is robust') 
else
    disp('Phase Margin is NOT robust')
end


if Gm == Inf
   disp('Gain Margin is infinite')
elseif Gm >= 2
   disp('Gain Margin is robust')
else
   disp('Gain Margin is NOT robust')
end


if 1/Gm == Inf
   disp('Modulus Margin is infinite') 
elseif 1/Gm >= 0.5
   disp('Modulus Margin is robust') 
else
   disp('Modulus Margin is NOT robust')
end

T = (G*C)/(1+G*C);
[T_poles] = pole(T);
% Feedback loop (Closed loop)
% figure()
% bode ((G*C)/(1+G*C))
% title('Bode Diagram Closed Loop')



% Gives feedback on stability and robustness

% [Gm,Pm,Wcg,Wcp] = margin(C);
% 
% % Stablity
% [G_poles] = pole(C);
% if G_poles <= 0
%    disp('Poles are stable') 
% else
%    disp('Poles are NOT stable')
% end
% 
% % Robustness
% if Pm == Inf
%    disp('Phase Margin is infinite') 
% elseif Pm >= 30
%    disp('Phase Margin is robust') 
% else
%     disp('Phase Margin is NOT robust')
% end
% 
% 
% if Gm == Inf
%    disp('Gain Margin is infinite')
% elseif Gm >= 2
%    disp('Gain Margin is robust')
% else
%    disp('Gain Margin is NOT robust')
% end
% 
% 
% if 1/Gm == Inf
%    disp('Modulus Margin is infinite') 
% elseif 1/Gm >= 0.5
%    disp('Modulus Margin is robust') 
% else
%    disp('Modulus Margin is NOT robust')
% end

% Create figures
% Nyquist
% figure()
% nyquist(C)

%Both the margins should be positive or phase margin should be greater than the gain margin.
% Bode
% figure()
% margin(C)

