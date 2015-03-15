function [ word_distrib, topic_distrib ] = lda( K, alpha, beta, nIter, b )
%   Based on tutorial: https://shuyo.wordpress.com/category/machine-learning/lda/
%
%   Inputs:
%   alpha: the dirichlet prior for the distribution of topics - P(topic | document)
%
%   beta: the dirichlet prior for the distribution of words - P(word | topic)
%
%   nIter: number of iterations
%   
%   K: the number of topics 
%
%   Outputs:
%   word_distrib: an K x V matrix where word_distrib(z, t) is the number of times the
%   t'th word in the vocabulary is assigned to topic z divided by the
%   number of occurrences of the t'th word
%
%   topic_distrib: a 1 x K matrix, where topic_distrib(z) is the number of words (across all
%   documents) assigned to topic z, after LDA has completed

dir_name_arr = ['./pass_clean/'; './fail_clean/'];
[ docs, vocab_size ] = read_files(dir_name_arr);
[ docword_topic, doctopic_prevalence, topic_word_distrib, topic_distrib ] = random_topic_assignment(docs, vocab_size, K);
perp = zeros(1, nIter);

for i = 1:nIter
    fprintf(1, 'iteration: %d\n', i);
    [ docword_topic, doctopic_prevalence, topic_word_distrib, topic_distrib ] = learn_distributions( alpha, beta, docs, docword_topic, doctopic_prevalence, topic_word_distrib, topic_distrib, vocab_size);
    [top_words, word_distrib] = word_dist(topic_word_distrib, topic_distrib, beta, vocab_size, b);
    perp(i) = perplexity(doctopic_prevalence, word_distrib, docs, K, alpha);
    disp(strcat('Perplexity: ',int2str(perp(i))));
end

[top_words, word_distrib] = word_dist(topic_word_distrib, topic_distrib, beta, vocab_size, b);
td = topic_dist(doctopic_prevalence, alpha);

dlmwrite('./word_dist.txt',word_distrib);
dlmwrite(strcat('./train_features/topic_dist_k',int2str(K),'.txt'),td);
dlmwrite('./perplexity.txt',perp);
dlmwrite('./topic_word_count.txt', topic_distrib);
dlmwrite('./doc_topic_word_count.txt', doctopic_prevalence);
dlmwrite('./topic_vocab_count.txt', topic_word_distrib);
dlmwrite('./doc_word_topicassignment.txt', docword_topic);

graph_perp(nIter, perp);

for i = 1:size(top_words, 1)
    dlmwrite('./top_word_ids.txt',top_words)
end

end

