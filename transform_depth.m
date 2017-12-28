% 2017-12-28
% Jorge Madrid
% SPIM2 _ Light Field support software
%
% Function that reshapes depth from slices to alpha then from alpha to Z
% Objective: obtain intensity profiles as functions of Z in um

function depth_corrected_profile = transform_depth(profile_filename, theta, alpha_spacing, alpha_min)

data = csvread(profile_filename, 2, 1);

% Assign arrays
X = data(:,1);
Y = data(:,2);

%x = linspace(1,59,59);

%% Transform slices to alpha
alpha = X*cos(theta)*alpha_spacing+alpha_min;

%% Transform alpha to Z
a = 0.7608;                 % Values obtained from alpha-to-depth calibration
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
truncated_idx = find(alpha<upper_bound & alpha>lower_bound);     % Find indexes
z_truncated = z(truncated_idx);                                  % Keep elements within domain
Y_truncated = Y(truncated_idx);

depth_corrected_profile = [z_truncated, Y_truncated];

clear data

end

