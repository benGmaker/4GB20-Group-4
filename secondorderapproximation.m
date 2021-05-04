t=1:100;
% figure()
% hold on
% plot(t,Rx)
% plot(t,Rz)
% plot(t,Rr)
% legend('Rx','Rz','Rr')

b = polyfit(Rx(1:100), t(:), 4);                   % Estimate Parameters For Quadratic Fit
y_fit = polyval(b, Rx(1:100));                        % Evaluate Fitted Curve

figure(1)
plot(Rx(1:100), t(:), 'pg')
hold on
plot(Rx(1:100), y_fit, '-r')
hold off