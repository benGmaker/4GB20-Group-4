clear all; clc;
%% 
syms R1 R2 Rxa Rz % L1 L2 L3 L4 L5 L6 L7

L1 = 81;
L2 = 165;
L3 = 80;
L4 = 130;
L5 = 130;
L6 = 120;
L7 = 65;
L8 = 50;

%% Equations
er1 = L3*sin(Rxa) + L4*cos(R1) + L7*cos(R2);
er2 = L5*cos(Rz) + (L6+L7)*cos(R2);
eqnr = er1 == er2;

ez1 = L1 + L3*cos(Rxa) + L4*sin(R1) - L7*sin(R2) - L8;
ez2 = L1 + L2 + L5*sin(Rz) - (L6 + L7)*sin(R2) - L8;
eqnz = ez1 == ez2;

[solR1 solR2] = solve([eqnr, eqnz], [R1, R2]);
sR1 = simplify(solR1);
sR2 = simplify(solR2);

er1 = subs(er1, [R1, R2], [sR1(1), sR2(1)]);
er2 = subs(er2, R2, sR2(1));

ez1 = subs(ez1, [R1, R2], [sR1(1), sR2(1)]);
ez2 = subs(ez2, R2, sR2(1));

%% Checking if it's correct
% input angles
iRx = deg2rad(30);
iRz = deg2rad(45);

% both values should be equal for r and z
% both values should be in range of motion if proper angles are chosen
Sr = [double(subs(er1, [Rxa, Rz], [iRx, iRz])) double(subs(er2, [Rxa, Rz], [iRx, iRz]))]
Sz = [double(subs(ez1, [Rxa, Rz], [iRx, iRz])) double(subs(ez2, [Rxa, Rz], [iRx, iRz]))]

%% Inverting r & z with Rx and Rz
% Desired position
r = 250;
z = 6;

% required angles
[sRx sRz] = vpasolve([er1 == r, ez1 == z], [Rxa, Rz]);
sRx = rad2deg(double(sRx))
sRz = rad2deg(double(sRz))

