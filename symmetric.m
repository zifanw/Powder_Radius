function [ output ] = symmetric( vector )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
axis = 150;
[p,q]=size(vector(1,:));
output = zeros(p,q);
for i = 1:q
    output(1,i) = 2*axis- vector(1,i);
end
%plot(output);
end

