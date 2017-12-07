function [ output ] = Partition( x )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[p,q]=size(x);

for i=150:400
    output(1,i-149) = x(1,i);
end
%output = uint8(output);
end
