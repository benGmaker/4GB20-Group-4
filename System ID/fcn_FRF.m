function [magR, phaR, magX, phaX, magZ, phaZ, freq] = fcn_FRF(inR, outR, inX, outX, inZ, outZ, nfft, fs)

[H_R, f_R] = tfestimate(inR, outR, hann(nfft), [], nfft, fs);
[H_X, f_X] = tfestimate(inX, outX, hann(nfft), [], nfft, fs);
[H_Z, f_Z] = tfestimate(inZ, outZ, hann(nfft), [], nfft, fs);

phaR = rad2deg(angle(H_R));
phaX = rad2deg(angle(H_X));
phaZ = rad2deg(angle(H_Z));

magR = 10*log10(abs(H_R));
magX = 10*log10(abs(H_X));
magZ = 10*log10(abs(H_Z));

for i = 1:length(phaR)-1
    if phaR(i+1) - phaR(i) >= 300
        phaR(i+1:end) = phaR(i+1:end) - 360;
    elseif phaR(i+1) - phaR(i) <= -300
        phaR(i+1:end) = phaR(i+1:end) + 360;
    end
end

for i = 1:length(phaX)-1
    if phaX(i+1) - phaX(i) >= 300
        phaX(i+1:end) = phaX(i+1:end) - 360;
    elseif phaX(i+1) - phaX(i) <= -300
        phaX(i+1:end) = phaX(i+1:end) + 360;
    end
end

for i = 1:length(phaZ)-1
    if phaZ(i+1) - phaZ(i) >= 300
        phaZ(i+1:end) = phaZ(i+1:end) - 360;
    elseif phaZ(i+1) - phaZ(i) <= -300
        phaZ(i+1:end) = phaZ(i+1:end) + 360;
    end
end

freq = f_R*2*pi;

end