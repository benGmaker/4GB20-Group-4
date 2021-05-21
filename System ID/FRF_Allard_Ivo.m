clc;

%% Read output
out_R_dat = out_R.data;
out_X_dat = out_X.data;
out_Z_dat = out_Z.data;

%% Turn into iddata object
R_dat = iddata(out_R_dat,R',Ts);
X_dat = iddata(out_X_dat,X',Ts);
Z_dat = iddata(out_Z_dat,Z',Ts);

%% PSD
[pRR,f_R] = pwelch(out_R_dat, 2048, 1024, 4096);

figure(1)
plot(f_R,10*log10(pRR).*f_R)
xlabel('Frequency (Hz)')
ylabel('PSD (dB)')

%% Spectral analysis
% FRF_R = spa(R_dat, 20480, []);

%% Visualize in Bode
% figure()
% bode(FRF_R)