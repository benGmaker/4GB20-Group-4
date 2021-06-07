function [Rx,Rr,Rz] = trajectory_planning(r1,r2,z1,phi1,phi2)
% Function that outputs Rx, Rr and Rz as function of r1, r2, phi1 and phi2.
% z1 is constant, however it is different for the calibration hole, so at
% the first position it should be set to height of calibration hole and
% after that at 15 mm.

IK = load("eqn_IK_robotarm.mat");

% Up
r = linspace(r1, r1, 100);
z = linspace(z1, 50, 100);
[Rxa,Rza] = fcn_IK(r, z, IK);
Rra = linspace(phi1,phi1,100);

% Move
r = linspace(r1, r2, 100);
z = linspace(50, 50, 100);
[Rxb,Rzb] = fcn_IK(r, z, IK);
Rrb = linspace(phi1,phi2,100);

% Down
r = linspace(r2, r2, 100);
z = linspace(50, 15, 100);
[Rxc,Rzc] = fcn_IK(r, z, IK);
Rrc = linspace(phi2,phi2,100);
Rx=[Rxa,Rxb,Rxc];Rz=[Rza,Rzb,Rzc];Rr=[Rra,Rrb,Rrc];



%% Test:
% [Rx,Rr,Rz] = trajectory_planning(150,130,15,-30,42);
% t=1:300;
% figure()
% hold on
% plot(t,Rx)
% plot(t,Rz)
% plot(t,Rr)
% legend('Rx','Rz','Rr')