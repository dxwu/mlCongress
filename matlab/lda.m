function [ output_args ] = lda( K, alpha, beta, nIter )
%UNTITLED2 Summary of this function goes here
%   Inputs:
%   alpha: the dirichlet prior for the distribution of topics - P(topic | document)
%
%   beta: the dirichlet prior for the distribution of words - P(word | topic)
%
%   nIter: number of iterations
%   
%   K: the number of topics 


fprintf(1,'sdf: %d\n', 3);
[ docs, V ] = read_files();
[ z_m_n, n_m_z, n_z_t, n_z ] = random_topic_assignment(docs, V, K);
for i = 1:nIter
    fprintf(1, 'iteration: %d\n', i);
    [ z_m_n, n_m_z, n_z_t, n_z ] = learn_distributions( alpha, beta, docs, z_m_n, n_m_z, n_z_t, n_z, V);
    %disp(sum(z_m_n(3,:)));
end

b=15;
[top_words, wd] = word_dist(n_z_t, n_z, beta, V, b);
td = topic_dist(n_m_z, alpha);

dlmwrite('./word_dist.txt',wd);
dlmwrite('./topic_dist.txt',td);


for i = 1:size(wd, 1)
    %should print out 1 each time
    %disp(sum(wd(i,:)));
end
disp(top_words)
for i = 1:size(top_words, 1)
    dlmwrite('./top_word_ids.txt',top_words)
end

output_args = 1;
end

