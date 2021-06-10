close all; clc
%%

load('err_omega.mat')
%%
e = [e1, e2, e3, e4];
w = [w1, w2, w3, w4];

%%
scatter(w,e)
xlabel('Angular velocity \omega [rad/s]')
ylabel('Error [V]')
title('Dynamic friction derivation')
grid on

%%

p = polyfit(w,e,1)

w_val = 0:0.001:2;
e_val = polyval(p, w_val);

plot(w_val, e_val)
