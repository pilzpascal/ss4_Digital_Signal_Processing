clear; close all; clc;

img = imread('pavian.png'); % Choose any picture you like here
img = rgb2gray(img);

%% Display image
figure; subplot(131);
imshow(img);
title('Ausgangsbild');

%% FFT
fft2d = fft2(img);

% Display the FFT image.
subplot(132);
imshow(log(fftshift(abs(fft2d))), []);
% imshow(log(abs(fft2d)), []);
title('2D-FFT');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
%Your turn
a = 130;
val = 0;

fft2d = fftshift(fft2d);
fft2d(a:298-a, a:298-a) = val;
fft2d = reshape(fft2d, [298 298]);
fft2d = fftshift(fft2d);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IFFT to obtain filtered image
img_filtered = ifft2(fft2d);
subplot(133);
imshow(real(img_filtered), []);
title('Gefiltertes Ausgangssignal');
