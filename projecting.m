function [ output ] = projecting( file )
% extract all the frames of a video
% INPUT 
%   file: the file containing all the frame images
% OUTPUT
%   output: a matrix containing all the frames

for i = 1:5001
    image_address = strcat(file,'/10g_',num2str(i),'.jpg'); % extract each gram
    Image = imread(image_address); % read the frame
    processedI = sample(Image); % sample the region of interest 6*251 pixels
    Distribution{i}=processedI; %construct the matrix to store the smapled matrix
end
output = Distribution;
end

