function [  ] = Frm( title )
% this function generates a file containing all the frames
% INPUT:
%   title: the title of the frame

file = VideoReader(title); % read the video
Total = file.NumberOfFrames; % acquire the total number of frames
for i = 1:Total
frame = read(file,i);
imwrite(frame,strcat('10g_',num2str(i),'.jpg'),'jpg'); % export the image of each frame
end

end

