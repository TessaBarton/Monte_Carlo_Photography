%% Clean up
% These functions calls clean up the MATLAB environment and close all windows
% open "extra" windows.
clear all
close all


%% Variables
% The next few lines define variables for the locations and types of image files
% we will be reading and writing. You  will likely want to change the input and
% output directories to match you personal environment.
input_dir = '\\HMC.Edu\HMCDFS\HMC_2016\mvy\My Documents\prokudin-gorsky\small\';
output_dir = '~Documents\out';
file_ext = 'tif';
file_name = '00888a_tiny.tif';


%% Read image file
% Here we read the input jpg file into a 3D array of 8-bit integers. Before we
% start to manipulate this image it is very important that we first convert the
% integer values into doubles.
I = imread([input_dir file_name]);
I = im2double(I);

%% Get image size
[v_sz, h_sz] = size(I);
v_sz = floor(v_sz / 3);

%% Split image into three color channels
B = I(1:v_sz,:);
G = I(v_sz+1:2*v_sz,:);
R = I(2*v_sz+1:3*v_sz,:);

%% Loop through the window and shift G
lowestSSD = Inf;
for vOffset = -20:20
    for hOffset = -20:20
        shiftedImage = circshift(G, [vOffset hOffset]);
        
        %% Loop through entire image and calculate SSD
        SSD = sum(sum((B-shiftedImage).^2));
        %% Replace the SSD if this offset produces better match
        if(SSD < lowestSSD)
            lowestSSD = SSD;
            optimalBounds = [vOffset, hOffset];
        end
    end
end

%% Display color channels
% Now we display each of the color channels separately in a new window.
newG = circshift(G, optimalBounds);
output = cat(3, B, newG, R);

figure
imshow(output)

