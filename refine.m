function [output] = refine( distribution,threshold )
% this function eleminate the KL divergence larger than threshold
output = 0;
for i = 1:5001
    if distribution(1,i) <= threshold
        output = [output,i];
    end
end
output(1) = [];
end

