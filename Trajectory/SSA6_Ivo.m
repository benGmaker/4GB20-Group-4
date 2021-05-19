close all; clc
%% Manual derivative
out_omega_R = diff(out_R.data)/Ts;
out_omega_X = diff(out_X.data)/Ts;
out_omega_Z = diff(out_Z.data)/Ts;

out_alpha_R = diff(out_omega_R)/Ts;
out_alpha_X = diff(out_omega_X)/Ts;
out_alpha_Z = diff(out_omega_Z)/Ts;

%% Preprocessing
ind_R = find(diff(out_R.data) > 0, 1 );
out_R_pre = out_R.data(ind_R:end);
out_R_time_pre = out_R.time(1:length(out_R_pre)) + out_R.time(ind_R);

ind_X = find(diff(out_X.data) > 0);
out_X_pre = out_X.data(ind_X:end);
out_X_time_pre = out_X.time(1:length(out_X_pre)) + out_X.time(ind_X);

ind_Z = find(diff(out_Z.data) > 0);
out_Z_pre = out_Z.data(ind_Z:end);
out_Z_time_pre = out_Z.time(1:length(out_Z_pre)) + out_Z.time(ind_Z);
%% Fitting polynomial
% Angle R
[poly_R, S_R] = polyfit(out_R_time_pre, out_R_pre, 5);
[out_R_poly, err_R] = polyval(poly_R, out_R_time_pre, S_R);
m_err_R = mean(err_R)

% Angular speed R
poly_omega_R = fcn_poly_derivative(poly_R);
out_omega_R_poly = polyval(poly_omega_R, out_R_time_pre);

% Angular acceleration R
poly_alpha_R = fcn_poly_derivative(poly_omega_R);
out_alpha_R_poly = polyval(poly_alpha_R, out_R_time_pre);

figure()
plot(out_R_time_pre, out_alpha_R_poly)


% [poly_X, S_X] = polyfit(out_X_time_pre, out_X_pre, 3);
% [out_X_poly, err_X] = polyval(poly_X, out_X_time_pre, S_X);
% m_err_X = mean(err_X)
% 
% [poly_Z, S_Z] = polyfit(out_Z_time_pre, out_Z_pre, 4);
% [out_Z_poly, err_Z] = polyval(poly_Z, out_Z_time_pre, S_Z);
% m_err_Z = mean(err_Z)

%% Plots
figure(1)
plot(out_R.time, out_R.data, out_R_time_pre, out_R_poly);
legend('phi_R', 'poly phi_R', 'location', 'northwest')
title('Approximation phi_R')

figure(2)
plot(out_R.time(1:end-1), out_omega_R, out_R_time_pre, out_omega_R_poly)
legend('omega_R', 'poly omega_R', 'location', 'northwest')
title('Approximation omega_R')

figure(3)
plot(out_R_time_pre, out_alpha_R_poly)
title('Approximation alpha_R')


% figure(2)
% plot([0:Ts:Ts*(L_sim-2)], out_omega_R); hold on
% plot([0:Ts:Ts*(L_sim-2)], out_omega_X)
% plot([0:Ts:Ts*(L_sim-2)], out_omega_Z)
% legend('omega_R', 'omega_X', 'omega_Z')
% title('Angular velocities')
% 
% figure(3)
% plot([0:Ts:Ts*(L_sim-3)], out_alpha_R); hold on
% plot([0:Ts:Ts*(L_sim-3)], out_alpha_X)
% plot([0:Ts:Ts*(L_sim-3)], out_alpha_Z)
% legend('alpha_R', 'alpha_X', 'alpha_Z')
% title('Angular accelerations')

