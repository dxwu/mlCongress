function [ ] = classify( K, alpha, beta, nIter, b, dir_name_arr )

%   For each bill in the directories listed in dir_name_arr, compute the
%   features (i.e. posterior topic probabilities), and write the feature
%   vectors to a file in the test_features directory

%   Sorry, but alpha, beta, nIter, b are unnecessary parameters. It is
%   safer not to remove them since classify is called in a lot of places.

word_distrib = dlmread('./word_dist.txt', ',');
topic_distrib = dlmread('./topic_word_count.txt', ',');

[ docs, V ] = read_files( dir_name_arr );
[ m, n ] = size(docs);
k = length(topic_distrib);
topic_distrib = (topic_distrib + eps) / sum(topic_distrib);
probDist = zeros(m, k);

for d = 1:m                 % for each document
    N = sum(docs(d,:) ~= 0);
    for z = 1:k   % for each topic
        prob = 0;
        
        for p = 1:n         % for each word in document
            if (docs(d, p) == 0)
                break;
            end
            prob = prob + log(word_distrib(z, docs(d, p)))/N;
        end
        prob = prob + log(topic_distrib(z))/N;
        probDist(d, z) = prob;
        probDist(d, z) = probDist(d, z);
    end
    probDist(d,:) = exp(probDist(d,:));
    probDist(d,:) = probDist(d,:) / sum(probDist(d,:));
end

dlmwrite(strcat('./test_features/topic_dist_test_k',int2str(K),'.txt'),probDist);


