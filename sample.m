function [ output ] = sample( image )
%   Detailed explanation goes here
% sample the specific 6*251 pixel^2 area 
Y = zeros(5,511);
for i = 1:6
    for j = 1:511
        Y(i,j) = image(i+332,j+120);
    end
end
Y = uint8(Y); 
output = Y;
end

