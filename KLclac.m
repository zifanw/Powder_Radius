function [ output ] = KLclac( dis,average )

for i = 1:5001
    vector = dis{i};
    output(1,i) = KLDiv(vector,average); %claculate KL divergence
end

end
   


