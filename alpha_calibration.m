
%%%%%%%% 2017 12 27
% Alpha calibration
% 
% Extract relation between alpha and depth of refocused plane 

ORIGIN = 'C:\Users\Jorge Andres\Documents\MATLAB\procesar_campo_de_luz';
INPUT = 'input';
OUTPUT = 'output';



% Load all images
imagefiles = dir('*.tif');      
nfiles = length(imagefiles);    % Number of files found
for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
    
   procesar_campo_de_luz_20171227(currentfilename);
   
    cd(OUTPUT);
    stackfiles = dir('*.tiff');      
    nstackfiles = length(stackfiles);    % Number of files found
    for i=1:nstackfiles
        currentstackfilename = stackfiles(i).name;
        currentplane = imread(currentstackfilename);
        planes(:,:,i) = currentplane;
    end
   
   for  
   
   
   cd(ORIGIN)
end
