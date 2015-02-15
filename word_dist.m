function [ top_words, n_z_t ] = word_dist( n_z_t, n_z, beta, V, b )
%UNTITLED3 Summary of this function goes here
%
%   Inputs:
%   n_z_t: an K x V matrix where n_z_t(z, t) is the number of times the
%   t'th word in the vocabulary is assigned to topic z
%       Note: the same word in diffierent documents may be assigned to
%       different topics
%
%   n_z: a 1 x K matrix, where n_z(z) is the number of words (across all
%   documents) assigned to topic z
%
%   beta: the dirichlet prior for the distribution of words - P(word | topic)
%
%   V: size of vocabulary

K = length(n_z);
for i = 1:K
    n_z_t(i, :) = (n_z_t(i, :) + beta) / (n_z(i) + V * beta);
end

top_words = zeros(K, b);
for j = 1:K
    %source: http://stackoverflow.com/questions/2692482/get-the-indices-of-the-n-largest-elements-in-a-matrix
    [sortedValues,sortIndex] = sort(n_z_t(j,:),'descend');  %# Sort the values in
    %isp(sortIndex(1:b));                                              %#   descending order
    top_words(j, :) = sortIndex(1:b);  %# Get a linear index into A of the 5 largest values
end
disp(top_words)
end

