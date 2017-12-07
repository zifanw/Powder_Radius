function [sigma,Leftfit,Rightfit,ExpWidth,MaxTangent] = G_A( ave,peakpoint,upf )
%  Use Reverse Abel Transformation and Guassian Ditribution Fit
%  
%  The function apply Reverse Abel Transformation on the average powder
%  radius and fit the result with Gaussian Distribution
%
%  INPUT:
%    ave: The average powder distribution
%    peakpoint: The i-th pixel where grayscale reaches the peak value
%    upf: Upper frequency (also see details in function 'Process')
%  
%  OUTPUT:
%    sigma: The standard deviation of Gaussian Distribution
%    Leftfit: The left fitting curve
%    Rightfit: The right fitting curve
%    ExpWidth: The 1/e^2 width value
%    MaxTangent: Maxmium Tangent Radius

%% seperate the average distribution into left and right part

left=ave(1:peakpoint);
right=ave(peakpoint:2*peakpoint-1); % to agree with the number of pixels of left side

remain = mod(peakpoint,2); 
if remain ~= 0  %if the peak value happens at odd pixel
    medium = peakpoint./2+1;
else            %if the peak value happens at even pixel
    medium = peakpoint./2;
end

%% flip the left part leftside right
for i = 1:medium
    t=left(i); % wrap the value 
    left(i) = left(peakpoint-i+1); 
    left(peakpoint-i+1)=t;
end
%% shift down the distribution 
left = left-min(left);
right = right-min(right);

%% Apply Reverse Able Transform on each part
% See detailed description in abel_inversion
[f_rec_l,~] = abel_inversion(left,peakpoint,upf,1,0);
[f_rec_r,~] = abel_inversion(right,peakpoint,upf,1,0);

%% transpose the result from column vector into row vector
 for i=1:peakpoint
d_l(i)=f_rec_l(i);
 end
 
for i=1:peakpoint
d_r(i)=f_rec_r(i);
end
 
%% Use Gaussian Distribution fit
% See detailed description in Gaussian
[A_l,B_l,sigma_L,D_l,Leftfit] = Gaussian(d_l);
[A_r,B_r,sigma_R,D_r,Rightfit] = Gaussian(d_r);

%% Find the 1/e^2 width
% See detailed description in HPW
ExpWidth_L = HPW(A_l,B_l,sigma_L,D_l);
ExpWidth_R = HPW(A_r,B_r,sigma_R,D_r);

%% Find the Maximum-Tangent Radius
% See detailed description in MT
MaxTangent_L = MT(Leftfit, B_l);
MaxTangent_R = MT(Rightfit, B_r);

%% Use the average value computed with left part and right part
ExpWidth = (ExpWidth_L+ExpWidth_R)./2;
MaxTangent = (MaxTangent_L+MaxTangent_R)./2;
sigma = (sigma_L+sigma_R)./2;
end

