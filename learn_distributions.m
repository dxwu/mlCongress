function [ docword_topic, doctopic_prevalence, topic_word_distrib, topic_distrib ] = learn_distributions( alpha, beta, docs, docword_topic, doctopic_prevalence, topic_word_distrib, topic_distrib, V)
%UNTITLED Summary of this function goes here
%   Inputs:
%   alpha: the dirichlet prior for the distribution of topics - P(topic | document)
%
%   beta: the dirichlet prior for the distribution of words - P(word | topic)
%
%   docs:  m x n matrix where docs(m, n) is the ID of the n'th word in the
%   m'th document, or 0 if the m'th document has less than n words
%
%   docword_topic: an m x n matrix where docword_topic(m, n) is the topic assigned to the
%   n'th word in the m'th document
%
%   doctopic_prevalence: an m x K matrix where doctopic_prevalence(m, z) is the number of words in
%   document m assigned to topic z
%
%   topic_word_distrib: an K x V matrix where topic_word_distrib(z, t) is the number of times the
%   t'th word in the vocabulary is assigned to topic z
%       Note: the same word in diffierent documents may be assigned to
%       different topics
%
%   topic_distrib: a 1 x K matrix, where topic_distrib(z) is the number of words (across all
%   documents) assigned to topic z
%
%   V: size of vocabulary

m = size(docs, 1);
n = size(docs, 2);

for i = 1:m
    for j = 1:n
        t = docs(i, j);
        
        %if there are no more words in the document, continue to the next
        %document by breaking out of the inner for loop
        if t == 0
            break;
        end
        
        z = docword_topic(i, j);
        
        %unassign word t to topic z
        doctopic_prevalence(i, z) = doctopic_prevalence(i, z) - 1;
        topic_word_distrib(z, t) = topic_word_distrib(z, t) - 1;
        topic_distrib(z) = topic_distrib(z) - 1;
        
        %z_prob is an K x 1 matrix, representing the probabilities that
        %word t in document i is assigned topic z
        z_prob = (topic_word_distrib(:, t) + beta) .* (doctopic_prevalence(i, :) + alpha)' ./ (topic_distrib + V * beta)';
        
        %normalize z_prob
        z_prob = z_prob / sum(z_prob);
        
        %randomly select a topic using z_prob distribution
        new_z = randsample(1:length(z_prob), 1, true, z_prob);
        
        docword_topic(i, j) = new_z;
        doctopic_prevalence(i, new_z) = doctopic_prevalence(i, new_z) + 1;
        topic_word_distrib(new_z, t) = topic_word_distrib(new_z, t) + 1;
        topic_distrib(new_z) = topic_distrib(new_z) + 1;
        
    end
end



end

