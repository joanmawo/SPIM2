IMFOLDER = 'input_LF';

num_a = '1';
num_b = '70';


name_a = strcat(IMFOLDER, '\Image', num_a, '.tif');
name_b = strcat(IMFOLDER, '\Image', num_b, '.tif');

im_a = imread(name_a);
im_a = im_a*1;
im_b = imread(name_b);
im_b = im_b*1;

im = imadd(im_a, im_b);

%imshow(im)

name_added = strcat(IMFOLDER, '\Image', num_a,'-',num_b, '.tif');
imwrite(im, name_added);
