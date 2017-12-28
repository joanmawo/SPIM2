% 2017-12-27
% Jorge Madrid
% SPIM2 _ Light Field support software
%
% Code that reshapes depth from slices to alpha then from alpha to Z
% Objective: obtain intensity profiles as functions of Z in um

% Assign arrays
X = X_1_57;
Y = Y_1_57;

%%%%% Constants
theta = 0.1222; % Angle of profile's abcise [rad] (can be easily measured with imageJ)
alpha_spacing = 0.05;
alpha_min = 0.1;

%x = linspace(1,59,59);

%% Transform slices to alpha
alpha = X*cos(theta)*alpha_spacing+alpha_min;

%% Transform alpha to Z
a = 0.7608;
b = 0.03898;
c = 1.511;
d = 36.87;

z = (1/b)*tan((alpha-c)/a)+d;
z = round(z, 1);

% Find valid domain of the function
syms Alpha(Z)
Alpha(Z) = a*atan(b*(Z-d))+c;

lower_bound = double(limit(Alpha, -inf));
upper_bound = double(limit(Alpha, inf));

%Truncate domain accordingly
%
% MUST BE DONE
%

truncated_idx = find(alpha<upper_bound & alpha>lower_bound);  % Find indexes
z_truncated = z(truncated_idx);                       % Keep elements within domain
Y_truncated = Y(truncated_idx);

%% Plotting
plot(z_truncated, Y_truncated, 'g*') %(alpha, Y,'g*')
xlabel('Z [um]')
ylabel('Intensity [AU]')
title('Depth-corrected intensity depth profile - Two 2um beads @0um & @28.5um- Normalized Intensity')
legend('Recorded Intensity','Fitted - Airy Functions', 'First Airy disk', 'Second Airy Disk')
xlim([-100 100])


