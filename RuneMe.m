%% MATLAB script for Assessment Item-1
close all;

% Step-1: Load input image
I = imread('AssignmentInput.jpg');
% reads the image from the file specified by filename,
% inferring the format of the file from its contents.
figure;
imshow(I);
% displays the image I in a graphics figure
title('Step-1: Load input image');

% Step-2: Conversion of input image to greyscale
I = rgb2gray(I);
% converts the truecolor image RGB to the grayscale intensity image.
figure;
imshow(I);

title('Step-2: Conversion of input image to greyscale');

% Step-3: Noise removal
I = medfilt2(I);
% Performs median filtering of the matrix A in two dimensions. 
% Each output pixel contains the median value in a 3-by-3 neighborhood 
% around the corresponding pixel in the input image. 
figure;
imshow(I);
title('Step-3: Noise removal');

% Step-4: Image Enhancement
J = imadjust(I);
% maps the intensity values in grayscale image I to new values in J 
% such that 1% of data is saturated at low and high intensities of I. 
% This increases the contrast of the output image J. 
K = imsharpen(J,'Radius',2,'Amount',1);
% Image that has been sharpened, returned as a nonsparse array the same
% size and class as the input image.
% Unsharp masking works by producing a blurred version of the image, 
% subtracting the blurred image from the original image to produce an edge image, 
% and then adding the edge image to the original image to produce a sharpened image. 
figure;
imshow(K);
title('Step-4: Image Enhancement');

% Step-5: Segment into foreground and background
mask = zeros(size(K));
% specifies the initial state of the active contour.
mask(5:end-5,5:end-5) = 1;
L = activecontour(K,mask,2000);
% The boundaries of the object regions define the initial contour position 
% used for contour evolution to segment the image. 
% segments the image by evolving the contour for a maximum of n iterations.
figure;
imshow(L);
title('Step-5: Segment into foreground and background');

% Step-6: Morphological processing
se = strel('disk',4);
% object represents a flat morphological structuring element,
% which is used as part of the dilation and erosion operations.  
II = bwareaopen(L,10);
% Removes all connected objects that have fewer than 10 pixels from
% the binary image L, producing another binary image II.
figure;
imshow(II);
title('Step-6: Morphological processing');


%Step-6: Automatic Recognition
b = bwlabel(II);
% returns the label matrix.
s = regionprops(b, 'Area', 'Perimeter');
% returns measurements for the set of properties specified
% by properties for each labeled region in the label matrix b.
% Area specifies the actual number of pixels in the region.
% Perimeter returns a scalar that 
% specifies the distance around the boundary of the region.

area = [s.Area];
perimeter = [s.Perimeter];
metric = 4*pi*area/perimeter.^2;
% indicating the roundness of an object.

display(area);

idx = find(((900 <= area) & (area <= 1200)) & ((0.05 <= metric) & (metric <= 0.15)));

bw2 = ismember(b, idx);
% returns an array containing true where the data in the labelled image is found in searched image. 
figure;
imshow(bw2);
title('Step-7: Automatic Recognition');






