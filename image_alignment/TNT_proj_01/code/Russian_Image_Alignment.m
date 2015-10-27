% Trang & Tessa
%% Clean up
% These functions calls clean up the MATLAB environment and close all windows
% open "extra" windows.

%% Variables
% The next few lines define variables for the locations and types of image files
% we will be reading and writing. You  will likely want to change the input and
% output directories to match you personal environment.
input_dir = '\\HMC.Edu\HMCDFS\HMC_2016\mvy\My Documents\prokudin-gorsky\';
output_dir = '/home/tbarton/Documents/MATLAB/';
file_ext = 'tif';
file_name = '00899a.tif';

%% Read image file
% Here we read the input jpg file into a 3D array of 8-bit integers. Before we
% start to manipulate this image it is very important that we first convert the
% integer values into doubles.
I = imread([input_dir file_name]);
I = im2double(I);

%% Get desired image height
[height, width] = size(I);
height = floor(height / 3);

%% Split image into three color channels
B = I(1:height,:);
G = I(height+1:2*height,:);
R = I(2*height+1:3*height,:);

[Bheight, Bwidth] = size(B);
[Gheight, Gwidth] = size(G);
[Rheight, Rwidth] = size(R);
% 
Bcropped = imcrop(B, [Bwidth*0.2 Bheight*0.2 Bwidth*0.6 Bheight*0.6]);
Gcropped = imcrop(G, [Gwidth*0.2 Gheight*0.2 Gwidth*0.6 Gheight*0.6]);
Rcropped = imcrop(R, [Rwidth*0.2 Rheight*0.2 Rwidth*0.6 Rheight*0.6]);

%% use pyramid scheme to find optimal fit
[R_x_shift, R_y_shift] = pyramid_scheme_tnt(Bcropped, Rcropped);
[G_x_shift, G_y_shift] = pyramid_scheme_tnt(Bcropped, Gcropped);


%% Display color channels
% Now we display each of the color channels separately in a new window.
newG = circshift(G, [G_x_shift, G_y_shift] );
newR = circshift(R, [R_x_shift, R_y_shift] );
output = cat(3,newR, newG, B);

figure;
subplot(1, 2, 1);
imshow(cat(3, R, G, B));
subplot(1, 2, 2);
imshow(output)