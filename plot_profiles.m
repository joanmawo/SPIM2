IMFOLDER = 'orthogonal';

im_name = strcat(IMFOLDER, '\YZ 1-90_crop', '.png');

im = imread(im_name);
im = rgb2gray(im);

profile_max = max(im, [], 2);
profile_mean = mean(im, 2);

[dim1, dim2] = size(profile_max);

z = linspace(1, dim1, dim1);

figure
plot(z,profile_max)
hold on
plot(z,profile_mean,'--')
title('Max and mean profiles over ROI');
xlabel('Z spim [px]');
ylabel('Intensity [AU]');
ylim([0 inf])
legend('max','mean');