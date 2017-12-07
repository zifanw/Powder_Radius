function [H] = horizontalize(object)
% This function diminish the skewing of background
% Input: 
%   object: The distribution needs horizontalizing
% OUTPUT:
%   H: Distribution after horizontalization
%   
%% Eleminating the slopes smaller than 0
[~,w] = size(object);
for i = 1:(w-1)/2
    slope = (object(1,(w-1)/2-i+1)-object(1,i))./((w-1)/2-2*i+1);
    if slope > 0
        output(1,i) = object(1,i);
        output(1,w-i+1) = object(w-i+1);
    else
    end
end
[~,e] = size(output);
%% line regression
x = 1:e;
k = polyfit(x,output,1); % use square least method find the regression line
A = k(1);
B = k(2);
H = object-(A*x+B)+78; %to accomodate the original distribution, shift the result up by 78 pixel
%figure;
%plot(H,'.');
%hold on;
%plot(output,'.');
end

