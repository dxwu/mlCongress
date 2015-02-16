function [ output_args ] = classify( K, alpha, beta, nIter, b, dir_name_arr )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[ wd, n_z ] = lda(K, alpha, beta, nIter, b);
[ docs, V ] = read_files( dir_name_arr );
[ m, n ] = size(docs);
k = length(n_z);
n_z = (n_z + eps) / sum(n_z);
probDist = zeros(m, k);

for d = 1:m                 % for each document
    N = sum(docs(d,:) ~= 0);
    for z = 1:k             % for each topic
        prob = 0;
        
        for p = 1:n         % for each word in document
            if (docs(d, p) == 0)
                break;
            end
            prob = prob + log(wd(z, docs(d, p)));
        end
        
        prob = prob + log(n_z(z));
        probDist(d, z) = prob;
        probDist(d, z) = exp(probDist(d, z) / N);
    end
    
    probDist(d,:) = probDist(d,:) / sum(probDist(d,:));
    disp(sum(probDist(d,:)));
end

output_args = 1;

