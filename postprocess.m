%% Figure
tiledlayout(3,1)

nexttile;
plot(ref_R); hold on
plot(out_R)
title('R')
legend('Reference', 'Response')
grid on
ylabel('Angle R [rad]')

nexttile;
plot(ref_X); hold on
plot(out_X)
title('X')
legend('Reference', 'Response')
grid on
ylabel('Angle X [rad]')

nexttile;
plot(ref_Z); hold on
plot(out_Z)
title('Z')
legend('Reference', 'Response')
grid on
ylabel('Angle Z [rad]')