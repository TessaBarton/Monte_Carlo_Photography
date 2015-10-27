%% Clean up
% These functions calls clean up the MATLAB environment and close all windows
% open "extra" windows.
clear all
close all


%% Variables
% The next few lines define variables for the locations and types of image files
% we will be reading and writing. You  will likely want to change the input and
% output directories to match you personal environment.
input_dir = '';
output_dir = '';
file_ext = 'jpg';
file_name = 'it_works_ee.jpg';

%% Read image file
% Here we read the input jpg file into a 3D array of 8-bit integers. Before we
% start to manipulate this image it is very important that we first convert the
% integer values into doubles.
I = imread([input_dir file_name]);
I = im2double(I);
R = I(:,:,1);
G = I(:,:,2);
B = I(:,:,3);

% contrastedImage = imadjust(I,[darkestRValue darkestGValue darkestBValue]; lightestRValue lightestGValue lightestBValue],[]);
R = imadjust(R);
B = imadjust(B);
G = imadjust(G);
contrastedImage = cat(3, R,B,G);

%% Attempt to do automatic contrasting
figure
subplot(1,2,1)
imshow(I)
subplot(1,2,2)
imshow(contrastedImage)
