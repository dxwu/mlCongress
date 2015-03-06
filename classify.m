function [ ] = classify( K, alpha, beta, nIter, b, dir_name_arr )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

wd = dlmread('./word_dist.txt', ',');
n_z = dlmread('./topic_word_count.txt', ',');

[ docs, V ] = read_files( dir_name_arr );
[ m, n ] = size(docs);
k = length(n_z);
n_z = (n_z + eps) / sum(n_z);
probDist = zeros(m, k);

for d = 1:m                 % for each document
    N = sum(docs(d,:) ~= 0);
    for z = 1:k   % for each topic
        prob = 0;
        
        for p = 1:n         % for each word in document
            if (docs(d, p) == 0)
                break;
            end
            prob = prob + log(wd(z, docs(d, p)))/N;
        end
        prob = prob + log(n_z(z))/N;
        probDist(d, z) = prob;
        probDist(d, z) = probDist(d, z);
    end
    probDist(d,:) = exp(probDist(d,:));
    probDist(d,:) = probDist(d,:) / sum(probDist(d,:));
end

dlmwrite('./topic_dist_test.txt', probDist);


