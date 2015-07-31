%%file path for data reading
omegaFile = 'test4-1_elogger.csv';
%forceFile = 'test4-1_lc.csv';

A = xlsread(omegaFile);
%B = xlsread(forceFile);

%time = A(:, 1);
throttle = A(:, 8);
throMap = (throttle-27)./(197-27);
%covert rpm unit to rad/s
omegaMin = A(:,17);
omegaSec = omegaMin./(60/2/pi);
%zForce = B(:, 3);

%first order fitting
pfThroOmega = polyfit(throMap, omegaSec, 1);
CthOmega = pfThroOmega(1);
BthOmega = pfThroOmega(2);

%Recalculate first order fitting for RPM value
omegaFit = throMap.*CthOmega + BthOmega;

%plot test result and first order fiting graph
h = figure(1);
plot(throMap, omegaSec, '.', throMap, omegaFit);
title('omegaSec to throttle')
legend('Test data','Polyfit data')
saveas(h,'Omega2throttle.bmp')
saveas(h,'Omega2throttle.fig')