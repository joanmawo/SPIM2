
%%%%%%%% 2017 12 27
% Alpha calibration
% 
% Extract relation between alpha and depth of refocused plane 

alpha_spacing = 0.10;
every_n_files = 2;

ORIGIN = 'C:\Users\Jorge Andres\Documents\MATLAB\procesar_campo_de_luz';
INPUT = 'input_LF';
OUTPUT = 'output';
RESULTS = 'resolution_measurements';


% Load all images
L = dir(fullfile(INPUT,'*.tif'));
imagefiles = natsortfiles({L.name});



results = zeros(numel(imagefiles), 3); % Preallocate memory for results

for ii=1:every_n_files:numel(imagefiles)
   currentfilename = imagefiles{ii};
    
   procesar_campo_de_luz_20171227(currentfilename, alpha_spacing);
   
    
    S = dir(fullfile(OUTPUT,'*.tiff')); 
    stackfiles = natsortfiles({S.name}); 
    
    for a=1:numel(stackfiles)
        currentstackfilename = fullfile(OUTPUT,stackfiles{a});
        currentplane = imread(currentstackfilename);
        planes(:,:,a) = currentplane;
    end
   
    % Extract intensity profiles along line for three valus of x
   for i=49:51
       currentprojection(:,:) = planes(i,:,:);
       
       x_endpoints = [1 35]; %316
       y_endpoints = [51 44];
       intensity_profile{i} = improfile(currentprojection, x_endpoints, y_endpoints);
       
   end
   
   % Localize maxima in these profiles
   for i=49:51
        
       [val, idx] = max(intensity_profile{i});
       
       results(ii, i-48) = idx;
       
   end
       
   clear planes
   clear currentplane
   clear currentprojection
          
end

filename = fullfile(RESULTS, strcat('results_', num2str(alpha_spacing*100), '-', num2str(every_n_files),'.txt'));
csvwrite(filename, results);
