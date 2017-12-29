ORIGIN = 'C:\Users\Jorge Andres\Documents\MATLAB\procesar_campo_de_luz';
INPUT = 'input_LF';
SUMSFOLDER = 'Added_LF';
OUTPUT = 'output';
PROFILES = 'profiles';
Z_CORRECTED = 'z_corrected';

% Constants
alpha_spacing = 0.05;
theta = 0.1541;
alpha_min = 0.2;


% Add light fields
for i=1:5:50
    for j=i:5:110
        add_light_fields(i,j);
    end
end

% Produce profiles
getprofiles(alpha_spacing);

L = dir(fullfile(PROFILES,'*.csv'));
profile_files = natsortfiles({L.name});

for ii=1:numel(profile_files)
    currentfilename = profile_files{ii};

    profile_filename = fullfile(PROFILES, currentfilename);
    depth_corrected_profile = transform_depth(profile_filename, theta, alpha_spacing, alpha_min);
    
    z_corrected_filename = fullfile(Z_CORRECTED, strcat('z_corrected_', currentfilename(1:end-4),'.csv'));
    csvwrite(z_corrected_filename, depth_corrected_profile);
    
end
