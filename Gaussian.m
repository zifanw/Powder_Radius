function [ a,b,c,d,yy ] = Gaussian( vector )
% this function use Gaussian Distribution to fit the original data
% INPUT:
%   vector: the original date
% OUTPUT
%   a: the peak value of the fitting curve
%   b: the expectation
%   c: square root 2 times standard deviation
%   d: a constant to cope with the data with minimum larger than 0
%   yy: fit curve

%% transform other type of data into double type
vector = double(vector);

%% Gaussian fit
[~,width]=size(vector);
G = 'a*exp(-((x-b)./c)^2)+d'; % fit function
x = 1:1:width; % plotting interval
startpoint = [1,0,20,0]; % the starting fitring value of a,b,c and d. Wise choice of startpoint 
                         %save the time and increase the accuracy of fit
[cfun,~] = fit(x',vector',G,'StartPoint',startpoint);
yy = cfun.a*exp(-((x-cfun.b)/cfun.c).^2)+cfun.d; 
a = cfun.a;
b = cfun.b;
d = cfun.d;
c = cfun.c./sqrt(2); % standard deviation

end

