% 2017-12-27
% Jorge Madrid
% SPIM2 _ Light Field support software
%
% Code that reshapes depth from slices to alpha then from alpha to Z
% Objective: obtain intensity profiles as functions of Z in um

%%%%% Constants
theta = 0.1222; % Angle of profile's abcise [rad] (can be easily measured with imageJ)
alpha_spacing = 0.05;
alpha_min = 0.1;

%x = linspace(1,59,59);

%% Transform slices to alpha
alpha_1_57 = X_1_57*cos(theta)*alpha_spacing+alpha_min;

%% Transform alpha to Z
a = 0.7608;
b = 0.03898;
c = 1.511;
d = 36.87;

z_1_57 = (1/b)*tan((alpha_1_57-c)/a)+d;
z_1_57 = round(z_1_57, 1);

% Find valid domain of the function
syms alpha(z)
alpha(z) = a*atan(b*(z-d))+c

lower_bound = limit(alpha, -inf);
upper_bound = limit(alpha, inf);

%Truncate domain accordingly
%
% MUST BE DONE
%

%% Plotting
plot(alpha_1_57, Y_1_57,'g*')
xlabel('Alpha [ ]')
ylabel('Intensity [AU]')
title('Intensity depth profile - Two 2um beads @0um & @28.5um- Normalized Intensity')
legend('Recorded Intensity','Fitted - Airy Functions', 'First Airy disk', 'Second Airy Disk')


