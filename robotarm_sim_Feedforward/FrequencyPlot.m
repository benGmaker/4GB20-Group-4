x = error_X.data;
y = fft(x);   
f = (0:length(y)-1)*fs/length(y);

plot(f,abs(y))
xlabel('Frequency (Hz)')
ylabel('Magnitude')
title('Magnitude')
xlim([1,100])