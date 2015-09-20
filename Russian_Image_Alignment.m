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
input_dir = '/common/cs/cs181m/data/prokudin-gorsky/small/';
output_dir = '/home/tbarton/Documents/MATLAB/';
file_ext = 'tif';
file_name = '00888a_tiny.tif';


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

%% Loop through the window and shift G
G_optimal_shift = shift_image_tnt(B, G)
R_optimal_shift = shift_image_tnt(B, R)
%% Display color channels
% Now we display each of the color channels separately in a new window.
newG = circshift(G, G_optimal_shift);
newR = circshift(R, R_optimal_shift);
output = cat(3, B, newG, newR);



 figure;
 subplot(1, 2, 1);
 imshow(cat(3, R, G, B));
 subplot(1, 2, 2);
 imshow(output)

