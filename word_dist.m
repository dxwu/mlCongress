function [ top_words, topic_word_distrib ] = word_dist( topic_word_distrib, topic_distrib, beta, V, b )
%UNTITLED3 Summary of this function goes here
%
%   Inputs:
%   topic_word_distrib: an K x V matrix where topic_word_distrib(z, t) is the number of times the
%   t'th word in the vocabulary is assigned to topic z
%       Note: the same word in different documents may be assigned to
%       different topics
%
%   topic_distrib: a 1 x K matrix, where topic_distrib(z) is the number of words (across all
%   documents) assigned to topic z
%
%   beta: the dirichlet prior for the distribution of words - P(word | topic)
%
%   V: size of vocabulary
%
%   Outputs:
%   topic_word_distrib: an K x V matrix where topic_word_distrib(z, t) is the number of times the
%   t'th word in the vocabulary is assigned to topic z divided by the
%   number of occurrences of the t'th word
%
%   top_words: a K x b matrix where top_words(z,i) is the i'th most
%   frequent word for topic z

K = length(topic_distrib);
for i = 1:K
    topic_word_distrib(i, :) = (topic_word_distrib(i, :) + beta) / (topic_distrib(i) + V * beta);
end

top_words = zeros(K, b);
for j = 1:K
    %source: http://stackoverflow.com/questions/2692482/get-the-indices-of-the-n-largest-elements-in-a-matrix
    [sortedValues,sortIndex] = sort(topic_word_distrib(j,:),'descend');  %# Sort the values in descending order
    top_words(j, :) = sortIndex(1:b);  %# Get a linear index into A of the 5 largest values
end

end
