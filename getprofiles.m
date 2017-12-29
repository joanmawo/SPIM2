% Produce profiles

function getprofiles(alpha_spacing)

    alpha_spacing = 0.05;
    every_n_files = 1;

    % Directories
    ORIGIN = 'C:\Users\Jorge Andres\Documents\MATLAB\procesar_campo_de_luz';
    INPUT = 'input_LF';
    SUMSFOLDER = 'Added_LF';
    OUTPUT = 'output';
    RESULTS = 'profiles';

    % Load all images
    L = dir(fullfile(INPUT,SUMSFOLDER,'*.tif'));
    imagefiles = natsortfiles({L.name});

    for ii=1:every_n_files:numel(imagefiles)
       currentfilename = imagefiles{ii};

       file = fullfile(SUMSFOLDER, currentfilename);
       procesar_campo_de_luz_20171227(file, alpha_spacing); % already has starting point the folder 'input_LF\'


        S = dir(fullfile(OUTPUT,'*.tiff')); 
        stackfiles = natsortfiles({S.name}); 

        for a=1:numel(stackfiles)
            currentstackfilename = fullfile(OUTPUT,stackfiles{a});
            currentplane = imread(currentstackfilename);
            planes(:,:,a) = currentplane;
        end

        % Extract intensity profiles along line for three valus of x
       i=50;
       currentprojection(:,:) = planes(i,:,:);

       x_endpoints = [1 56]; % For alpha_spacing = 0.05
       y_endpoints = [51 42];
       intensity_profile = improfile(currentprojection, x_endpoints, y_endpoints);
       
       z_coordinates = linspace(0,length(intensity_profile)-1,length(intensity_profile)).'; 
       pro = [z_coordinates intensity_profile];
       
       % Save profile to csv
       filename = fullfile(RESULTS, strcat('results_', currentfilename(1:end-4), '-', num2str(alpha_spacing*100),'.csv'));
       csvwrite(filename, pro);


       clear planes
       clear currentplane
       clear currentprojection
      % clear intensity_profile
       
    end

end
