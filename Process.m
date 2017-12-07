function [ new_dis,VR,sigma,Gaussian_fit,Ex,refined_average] = Process(dis)
%  Process this function measures the powder cloud radius
%  INPUT:
%      dis: the matrix containing frames exract from the video. The
%      extracting function refers to 'projecting'.
%  OUTPUT:
%      new_dis = post-flipped and trimmed distributions 
%      VR: Valid ratio. The percentage of frames with KL divergence less
%      than threshold.
%      sigma: the one-sigma value of Gaussian Distribution fit. 
%      Gaussian_fit: the Gaussian fit curve
%      Ex: Expectation, one parameter in Gaussian Distribution to locate
%      the centre line in a powder cloud.
%      refined_average: the average distribution refined by KL divergence
%      filter.

%% process frames with Partition and Symmetrilization
frame = zeros(1,251); 
t = zeros(1,251);
average = zeros(1,251);
NUM_FRAME = 5001; %the number of frames + 1

for i = 1:NUM_FRAME % for each frame of the 5000 frames
    matrix = dis{i}; % obtain each 6*251-matrix of ROI
    [p,~] = size(matrix); 
    for j = 1:p
        vector = matrix(j,:); % attain each row 
        vector = symmetric(vector); %flip the curve upside-down
        vector = Partition(vector); %eleminate irrelavent background pixel
        [~,q] = size(vector);
        for k = 1:q
        frame(1,k) = frame(1,k) + vector(1,k);
        end
    end
    

     frame = frame/6; % obtain mean distribution with 6 rows of each frame
     average = average + frame;
     new_dis{i} = frame;
     frame = zeros(1,251);
end
%% Find the average distribution
average = average/5000; % obtain the average distribution of each video

%% Calculate the KL divergence
KL_dis = KLclac(new_dis,average); %calculate KL divergence
axis([0 5001 0 0.005]);
CI = refine(KL_dis,0.003); % Confidence Interval after eliminating distributions with low relativity
[~,length] = size(CI);% obtain the length of CI
VR = length/(NUM_FRAME-1); % calculate the valid ratio

%% Acquire the refined average distribution
for k = 1:length
    t = t + new_dis{CI(1,k)};
end
refined_average = t/length;

%% Gaussian fit
[~,Ex,c,Gaussian_fit] = Gaussian(refined_average);
sigma = c./sqrt(2); %sigma
end

