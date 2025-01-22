% Histogram Equalization
% Created by Vipul Pawar

clc;
clear all;
close all;

% Generate a random 8x8 intensity matrix with values between 50 and 100
% This simulates a low-contrast grayscale image
I = round(50 + (100 - 50) * rand(8)); % Intensity values in the range [50, 100]

% Flatten the 8x8 matrix into a single row vector for processing
Ia = I(:)';

% Sort the intensity values to prepare for frequency calculation
sortIa = sort(Ia);

% Find unique intensity values and calculate their frequencies
[uniqueNumbers, ~, idx] = unique(sortIa); % Get unique intensity values
frequencies = accumarray(idx, 1);         % Count occurrences of each intensity

% Compute the cumulative distribution function (CDF) of intensities
cumulativeFrequencies = cumsum(frequencies);

% Calculate the total number of pixels in the image
totalPixels = numel(I);

% Identify the smallest non-zero CDF value to adjust the formula
cdf_min = min(cumulativeFrequencies(cumulativeFrequencies > 0));

% Define the total number of intensity levels for an 8-bit image (0 to 255)
L = 256;

% Apply the histogram equalization formula to compute new intensity values
h_v = round(((cumulativeFrequencies - cdf_min) / (totalPixels - cdf_min)) * (L - 1));

% Map the original intensity values to the new equalized values
equalizedImage = zeros(size(I)); % Initialize an empty matrix for the equalized image
for i = 1:length(uniqueNumbers)
    equalizedImage(I == uniqueNumbers(i)) = h_v(i);
end

% Convert the matrices to uint8 format for visualization
equalizedImage = uint8(equalizedImage);
I = uint8(I);

% Plot the histogram of the original image
figure(1);
subplot(2, 1, 1);
bar(uniqueNumbers, frequencies, 'FaceColor', 'b');
title('Original Histogram'); % Title for the original image histogram
xlabel('Intensity Values');
ylabel('Frequency');

% Plot the histogram of the equalized image
subplot(2, 1, 2);
bar(0:L-1, histcounts(equalizedImage(:), 0:L), 'FaceColor', 'r');
title('Equalized Histogram'); % Title for the equalized image histogram
xlabel('Intensity Values');
ylabel('Frequency');

% Display the original and equalized images side by side
figure(2)
subplot(1, 2, 1);
imshow(I); % Display the original image
title("Original Image");

subplot(1, 2, 2);
imshow(equalizedImage); % Display the equalized image
title("Equalised Image");
