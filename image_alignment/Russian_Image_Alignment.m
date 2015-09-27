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
input_dir = '';
output_dir = '';
file_ext = 'png';
file_name = 'example.png';



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

% [B_height, B_width] = size(B);
% [G_height, G_width] = size(G);
% [R_height, R_width] = size(R);
% 
% Bcropped = imcrop(B, [B_width*0.2 B_height*0.2 B_width*0.8 B_height*0.8]);
% Gcropped = imcrop(G, [G_width*0.2 G_height*0.2 G_width*0.8 G_height*0.8]);
% Rcropped = imcrop(R, [R_width*0.2 R_height*0.2 R_width*0.8 R_height*0.8]);

figure;
subplot(1, 3, 1);
imshow(I);
subplot(1, 3, 2);
imshow(G);
subplot(1, 3, 3);
imshow(R);
% 
% %% use pyramid scheme to find optimal fit
% [R_x_shift, R_y_shift] = pyramid_scheme_tnt(Bcropped, Rcropped);
% [G_x_shift, G_y_shift] = pyramid_scheme_tnt(Bcropped, Gcropped);
% 
% 
% %% Display color channels
% % Now we display each of the color channels separately in a new window.
% newG = circshift(G, [G_x_shift, G_y_shift] );
% newR = circshift(R, [R_x_shift, R_y_shift] );
% output = cat(3,newR, newG, B);
% 
%  figure;
%  subplot(1, 2, 1);
%  imshow(cat(3, R, G, B));
%  subplot(1, 2, 2);
%  imshow(output)
%  
%  
%  
% 
