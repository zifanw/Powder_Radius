function [ radius ] = MT(fit,Ex)
% This function calculate the max-tangent value
% INPUT
%  Gaussian_fit: the fit curve
%  Ex: Expectation
% OUTPUT
%  radius : maximum absolute tangent radius

d1 = diff(fit); % first-order differential
figure;
plot(d1);
[~,x] = min(d1); % find the indice of the minimum tangent
radius = abs(x-Ex);
end

