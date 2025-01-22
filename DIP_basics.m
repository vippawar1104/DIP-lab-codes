% Digital Image Processing
% Created by Vipul Pawar
clc;
clear all;
close all;

% Importing the image
image_url = 'https://media.istockphoto.com/id/504633706/photo/winter-pearl-lake.jpg?s=612x612&w=0&k=20&c=jmzs_o2blxe4m_PJoQCepBQpy5p4d9O0JewKG5OpUDw%3D';
original_image = imread(image_url);

% Convert the original image to grayscale using average method
red_channel = original_image(:, :, 1);
green_channel = original_image(:, :, 2);
blue_channel = original_image(:, :, 3);
grayscale_image = (double(red_channel) + double(green_channel) + double(blue_channel)) / 3;

% Count the sum of all pixel values in the grayscale image
total_intensity = sum(grayscale_image(:));

% Convert the grayscale image to black and white using a threshold
[image_height, image_width, ~] = size(original_image);
threshold = total_intensity / (image_height * image_width);
binary_image = grayscale_image > threshold;

% Create an all-blue version of the original image
blue_image = original_image;
blue_image(:, :, 1) = 0; % Remove red channel
blue_image(:, :, 2) = 0; % Remove green channel

% Create an all-green version of the original image
green_image = original_image;
green_image(:, :, 1) = 0; % Remove red channel
green_image(:, :, 3) = 0; % Remove blue channel

% Create an all-red version of the original image
red_image = original_image;
red_image(:, :, 2) = 0; % Remove green channel
red_image(:, :, 3) = 0; % Remove blue channel

% Plotting all the results
figure;

subplot(2, 3, 1);
imshow(original_image);
title("Original Image");

subplot(2, 3, 2);
imshow(uint8(grayscale_image)); % Convert to uint8 for display
title("Grayscale Image");

subplot(2, 3, 3);
imshow(binary_image);
title("Black & White Image");

subplot(2, 3, 4);
imshow(red_image);
title("Red Image");

subplot(2, 3, 5);
imshow(green_image);
title("Green Image");

subplot(2, 3, 6);
imshow(blue_image);
title("Blue Image");

% Empty spaces for pasting the result images
% You can paste your result images here for visualization or further processing
% For example, paste your images like this:
% resultImage1 = imread('/Users/vipulpawar/Desktop/Lab-1(Dip basics)');

% imshow(resultImage1); % Paste result image 1
