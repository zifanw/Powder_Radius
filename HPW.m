function [ output ] = HPW( Peak,Ex,sigma,d )
% HPW is initial for Half-Peak Width, the 1/e^2 width. 
% It denotes the distance from the peak to th point where the value equals to peak
% value times 1/e^2.
% INPUT:
%   Peak: the peak value
%   Ex: Expectation where it reaches peak value
%   sigma: standard deviation of Gaussian Distribution
%   d: height of Gaussian Distribution
% OUTPUT:
%   output: the result

c = sqrt(2).*sigma;
Half_Peak = Peak.*exp(-2)+d;
syms x;
f(x) = Peak*exp(-((x-Ex)/c)^2)+d;
F(x) = finverse(f); % find the inverse function of Gaussian function
output = double(abs(Ex - F(Half_Peak))); % 1/e^2 radius

end

