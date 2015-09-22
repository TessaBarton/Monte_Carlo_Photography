% Trang & Tessa
%% Clean up
% These functions calls clean up the MATLAB environment and close all windows
% open "extra" windows.
clear all
close all


%% Variables
% The next few lines define variables for the locations and types of image files
% we will be reading and writing. You  will likely want to change the input and
% output directories to match you personal environment.
input_dir = '/common/cs/cs181m/data/prokudin-gorsky/';
output_dir = '/home/tbarton/Documents/MATLAB/';
file_ext = 'tif';
file_name = '01648a.tif';



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



%% use pyramid scheme to find optimal fit
[R_x_shift, R_y_shift] = pyramid_scheme_tnt(B, R);
[G_x_shift, G_y_shift] = pyramid_scheme_tnt(B, G);


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
 
 
 

