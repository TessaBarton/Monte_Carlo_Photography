%% Clean up
% open "extra" windows.
clear all
close all


%% Variables
input_dir = '/common/cs/cs181m/data/office/';
output_dir = './';
input_file_ext = 'pgm';
output_file_ext = 'tif';
files = dir([input_dir '*.' input_file_ext]);


%% Iterate over all files
for file = files'
    % Read in the current image
    file_name = file.name
    I = im2double(imread([input_dir file_name]));
    
    % Artificially mosaic image
    % Create masks for each color channel
    R_mask = zeros(size(I));
    R_mask(1:2:end,1:2:end) = 1;
    B_mask = circshift(R_mask, [1,1]);
    G_mask = circshift(R_mask + B_mask, [1, 0]);
    
    % Extract the three color channels
    R = I .* R_mask;
    G = I .* G_mask;
    B = I .* B_mask;

    % Demosaic using nearest-neighbor algorithms
%     R = R + circshift(R, [0,1]);
%     R = R + circshift(R, [1,0]);
%     B = B + circshift(B, [0,1]);
%     B = B + circshift(B, [1,0]);
%     G = G + circshift(G, [0,1]);
%     J = cat(3, R, G, B);
    
    R = bil_interpolate(R);
    G = bil_interpolate(G);
    B = bil_interpolate(B);
    
    J = cat(3, R, G, B);
    
    % you know when a pixel isn't colored
    figure;
    imshow(J)

    % Write image as a color tif
    imwrite(J, [output_dir file_name(1:end-3) output_file_ext]);
end
