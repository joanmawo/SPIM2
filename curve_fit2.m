
F = @(x,Z_1_57_extended)x(1)*(2*besselj(1,x(2)*(Z_1_57_extended-x(3)))./(x(2)*(Z_1_57_extended-x(3)))).^2 + x(4)*(2*besselj(1,x(5)*(Z_1_57_extended-x(6)))./(x(5)*((Z_1_57_extended-x(6))))).^2 + x(7);

%xo = [10;0.2;14;5;0.1;35]; xo = [0.1;0.1366;0.3978;0.5484;0.01;42.273;3];[200;15;14.5;70;47;32.5;4];

options = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt');
% % ALPHA
% xo = [130;16;0.7;25;24;1.45;55];
% lb = [120;10;0.5;12;10;1.3;0];
% ub = [160;20;1;80;30;1.8;100];

% CORRECTED Z
% xo = [161;0.16;0.1;70;0.24;40;55];
% lb = [120;0.1;-10;12;0.1;30;0];
% ub = [220;100;10;1000;2.5;45;100];

% SLICES
xo = [161;0.16;28.37;25;0.24;44.9;55];
lb = [50;0.1;10;12;0.1;30;0];
ub = [220;100;30;1000;2.5;45;100];


[x,resnorm,~,exitflag,output] = lsqcurvefit(F,xo,Z_1_57_extended,Intensity_1_57_extended,lb,ub,options)

f1 = @(z) x(1)*(2*besselj(1,x(2)*(z-x(3)))./(x(2)*(z-x(3)))).^2 + x(7);
mini = fminbnd(f1, 10,60)

f2 = @(z) x(4)*(2*besselj(1,x(5)*(z-x(6)))./(x(5)*((z-x(6))))).^2 + x(7);
f2_minus = @(z) -x(4)*(2*besselj(1,x(5)*(z-x(6)))./(x(5)*((z-x(6))))).^2 + x(7);
maxi = fminbnd(f2_minus, 10,60)


plot(Z_1_57_extended,Intensity_1_57_extended,'*');
hold on
plot(Z_1_57_extended,F(x,Z_1_57_extended),'r-.');
plot(Z_1_57_extended,f1(Z_1_57_extended), 'k--');
plot(Z_1_57_extended,f2(Z_1_57_extended), 'b:');
xlabel('Z spim [um]')
ylabel('Intensity [AU]')
title('Z-corrected intensity depth profile - Two 2um beads @0um & @28.5um - Normalized Intensity')
legend('Recorded Intensity','Fitted - Airy Functions', 'First Airy disk', 'Second Airy Disk')
hold off



% x =
% 
%   105.0182
%     0.2397
%    12.7496
%    26.0786
%     0.1790
%    31.6148
%    30.2621
% 
% 
% resnorm =
% 
%    1.3410e+03
% 
% 
% exitflag =
% 
%      3
% 
% 
% output = 
% 
%   struct with fields:
% 
%     firstorderopt: 18.1777
%        iterations: 16
%         funcCount: 136
%      cgiterations: 0
%         algorithm: 'trust-region-reflective'
%          stepsize: 0.0039
%           message: 'Local minimum possible.??lsqcurvefit stopped because the final change in the sum of squares relative to ?its initial value is less than the default value of the function tolerance.??Stopping criteria details:??Optimization stopped because the relative sum of squares (r) is changing?by less than options.FunctionTolerance = 1.000000e-06.??Optimization Metric                                  Options?relative change r =   7.66e-07             FunctionTolerance =   1e-06 (default)'
% 
% 
% mini =
% 
%    28.7366
% 
% 
% maxi =
% 
%    31.6149