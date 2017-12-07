function [dist]=KLDiv(P,Q)
%  dist = KLDiv(P,Q) Kullback-Leibler divergence of two discrete probability
%  distributions
%  P and Q  are automatically normalised to have the sum of one on rows
% have the length of one at each 
% P =  n x nbins
% Q =  1 x nbins or n x nbins(one to one)
% dist = n x 1

P = double(P);
Q = double(Q);

%% normalize the distribution
P = P/sum(P);
Q = Q/sum(Q);

if size(P,2)~=size(Q,2)
    error('the number of columns in P and Q should be the same');
end

if sum(~isfinite(P(:))) + sum(~isfinite(Q(:)))
   error('the inputs contain non-finite values!') 
end
%% Caclulate the KL divergence
Quotient = log2(P) - log2(Q);
output =Quotient.*P;
dist = sum(output);



end