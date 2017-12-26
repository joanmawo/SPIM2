
F = @(x,Z_1_70_n)x(1)*(2*besselj(1,x(2)*(Z_1_70_n-x(3)))./(x(2)*(Z_1_70_n-x(3)))).^2 + x(4)*(2*besselj(1,x(5)*(Z_1_70_n-x(6)))./(x(5)*((Z_1_70_n-x(6))))).^2 + x(7);

%xo = [10;0.2;14;5;0.1;35]; xo = [0.1;0.1366;0.3978;0.5484;0.01;42.273;3];[200;15;14.5;70;47;32.5;4];

options = optimoptions('lsqcurvefit','Algorithm','levenberg-marquardt');
xo = [94;0.25;13.2;100;5.11;31.5;42.0619];
lb = [50;0.1;8;20;0.1;30;0];
ub = [220;100;16;1000;2.5;36;50];

[x,resnorm,~,exitflag,output] = lsqcurvefit(F,xo,Z_1_70_n,Intensity_1_70_n,lb,ub,options)

f1 = @(z) x(1)*(2*besselj(1,x(2)*(z-x(3)))./(x(2)*(z-x(3)))).^2 + x(7);
mini = fminbnd(f1, 10,35)

f2 = @(z) x(4)*(2*besselj(1,x(5)*(z-x(6)))./(x(5)*((z-x(6))))).^2 + x(7);
f2_minus = @(z) -x(4)*(2*besselj(1,x(5)*(z-x(6)))./(x(5)*((z-x(6))))).^2 + x(7);
maxi = fminbnd(f2_minus, 10,35)


plot(Z_1_70_n,Intensity_1_70_n,'*');
hold on
plot(Z_1_70_n,F(x,Z_1_70_n),'r-.');
plot(Z_1_70_n,f1(Z_1_70_n), 'k--');
plot(Z_1_70_n,f2(Z_1_70_n), 'b:');
xlabel('Z spim [slices]')
ylabel('Intensity [AU]')
title('Intensity depth profile - Two 2um beads separated 35um - Normalized Intensity')
legend('Recorded Intensity','Fitted - Airy Functions', 'First Airy disk', 'Second Airy Disk')
hold off






% x =
% 
%     1.4204
%     0.1366
%    25.3978
%     0.5484
%     0.0687
%    42.2730
% 
% 
% resnorm =
% 
%    3.4346e+03
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
%     firstorderopt: 15.7422
%        iterations: 9
%         funcCount: 70
%      cgiterations: 0
%         algorithm: 'trust-region-reflective'
%          stepsize: 0.0013

% syms z
% f1 = x(1)*(2*(besselj(1,x(2)*(z-x(3)))/x(2)).^2)
% f1_prime = diff(f1);
% 
% crit_pts1 = solve(f1_prime)
% 
% f2 = x(4)*(2*(besselj(1,x(5)*(z-x(6)))/x(5)).^2)
% f2_prime = diff(f2);
% crit_pts2 = solve(f2_prime)