clear all; clc;
%% 
syms R1 R2 Rx Rz % L1 L2 L3 L4 L5 L6 L7

L1 = 81;
L2 = 165;
L3 = 80;
L4 = 130;
L5 = 130;
L6 = 120;
L7 = 65;
L8 = 50;

%% Equations
% expression of r
er1 = L3*cos(Rx) + L4*cos(R1) + L7*cos(R2);
er2 = L5*cos(Rz) + (L6+L7)*cos(R2);
eqnr = er1 == er2;

% expression of z
ez1 = L1 + L3*sin(Rx) + L4*sin(R1) - L7*sin(R2) - L8;
ez2 = L1 + L2 + L5*sin(Rz) - (L6 + L7)*sin(R2) - L8;
eqnz = ez1 == ez2;

% solve both expressions for R1 and R2
[solR1 solR2] = solve([eqnr, eqnz], [R1, R2]);
sR1 = simplify(solR1);
sR2 = simplify(solR2);

% substitute in original expressions (you can choose either er1 or er2, same for ez. These should be the same)
er1 = subs(er1, [R1, R2], [sR1(2), sR2(2)]);
er2 = subs(er2, R2, sR2(2));

ez1 = subs(ez1, [R1, R2], [sR1(2), sR2(2)]);
ez2 = subs(ez2, R2, sR2(2));

%% Checking if it's correct
% input angles
iRx = deg2rad(60);
iRz = deg2rad(45);

% both values should be equal for r and z
% both values should be in range of motion if proper angles are chosen
Sr = [double(subs(er1, [Rx, Rz], [iRx, iRz])) double(subs(er2, [Rx, Rz], [iRx, iRz]))]
Sz = [double(subs(ez1, [Rx, Rz], [iRx, iRz])) double(subs(ez2, [Rx, Rz], [iRx, iRz]))]

%% Inverting r & z with Rx and Rz
% Desired position
r = 170;
z = 120;

% required angles
[sRx sRz] = vpasolve([er1 == r, ez1 == z], [Rx, Rz]);
sRx = rad2deg(double(sRx))
sRz = rad2deg(double(sRz))

