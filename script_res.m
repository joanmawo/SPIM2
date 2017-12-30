%% INITIALIZATION

ORIGIN = 'C:\Users\Jorge Andres\Documents\MATLAB\procesar_campo_de_luz';
INPUT = 'input_LF';
SUMSFOLDER = 'Added_LF';
OUTPUT = 'output';
PROFILES = 'profiles';
Z_CORRECTED = 'z_corrected';
MEASUREMENTS =  'resolution_measurements';

% Constants
alpha_spacing = 0.05;
theta = 0.1541;
alpha_min = 0.2;


%% Add light fields
for i=1:1:100
    for j=i:1:200
        add_light_fields(i,j);
    end
end

%% Produce profiles
getprofiles(alpha_spacing);

%% Transform profiles to correct them in Z
L = dir(fullfile(PROFILES,'*.csv'));
profile_files = natsortfiles({L.name});


for ii=1:numel(profile_files)
    currentfilename = profile_files{ii};

    profile_filename = fullfile(PROFILES, currentfilename);
    depth_corrected_profile = transform_depth(profile_filename, theta, alpha_spacing, alpha_min);
    
    z_corrected_filename = fullfile(Z_CORRECTED, strcat('z_corrected_', currentfilename(1:end-4),'.csv'));
    csvwrite(z_corrected_filename, depth_corrected_profile);
    
end

%% Evaluate resolution
L = dir(fullfile(Z_CORRECTED,'*.csv'));
profile_files = natsortfiles({L.name});

resolution_evaluation = zeros(numel(profile_files),3);

for ii=1:numel(profile_files)
    currentfilename = profile_files{ii};

    profile_filename = fullfile(Z_CORRECTED, currentfilename);
    resolvable = are_resolvable(profile_filename);
    
    s = profile_filename(38:end-3);
    c = strsplit(s, '-');

    zo_1 = str2double(c{1}); 
    zo_2 = str2double(c{2});
    
    resolution_evaluation(ii,1) = zo_1;
    resolution_evaluation(ii,2) = zo_2;
    resolution_evaluation(ii,3) = resolvable;
        
end

res_eval_filename = fullfile(MEASUREMENTS, strcat('resolution_evaluation','.csv'));
csvwrite(res_eval_filename, resolution_evaluation);

%% Plot resolution matrix


m = zeros(max(resolution_evaluation(:,1)), max(resolution_evaluation(:,2)));

for ir=1:length(resolution_evaluation)
    m(resolution_evaluation(ir,1),resolution_evaluation(ir,2))  = resolution_evaluation(ir,3);
end


imagesc(m)
colorbar

