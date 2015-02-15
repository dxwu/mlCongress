function [ z_m_n, n_m_z, n_z_t, n_z ] = learn_distributions( alpha, beta, docs, z_m_n, n_m_z, n_z_t, n_z, V)
%UNTITLED Summary of this function goes here
%   Inputs:
%   alpha: the dirichlet prior for the distribution of topics - P(topic | document)
%
%   beta: the dirichlet prior for the distribution of words - P(word | topic)
%
%   docs:  m x n matrix where docs(m, n) is the ID of the n'th word in the
%   m'th document, or 0 if the m'th document has less than n words
%
%   z_m_n: an m x n matrix where z_m_n(m, n) is the topic assigned to the
%   n'th word in the m'th document
%
%   n_m_z: an m x K matrix where n_m_z(m, z) is the number of words in
%   document m assigned to topic z
%
%   n_z_t: an K x V matrix where n_z_t(z, t) is the number of times the
%   t'th word in the vocabulary is assigned to topic z
%       Note: the same word in diffierent documents may be assigned to
%       different topics
%
%   n_z: a 1 x K matrix, where n_z(z) is the number of words (across all
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
        
        z = z_m_n(i, j);
        
        %unassign word t to topic z
        n_m_z(i, z) = n_m_z(i, z) - 1;
        n_z_t(z, t) = n_z_t(z, t) - 1;
        n_z(z) = n_z(z) - 1;
        
        %disp(size(n_z_t(:, t) + beta));
        %disp(size(n_m_z(i, :) + alpha));
        %disp(size((n_z + V * beta)));
        
        %z_prob is an K x 1 matrix, representing the probabilities that
        %word t in document i is assigned topic z
        z_prob = (n_z_t(:, t) + beta) .* (n_m_z(i, :) + alpha)' ./ (n_z + V * beta)';
        
        %normalize z_prob
        z_prob = z_prob / sum(z_prob);
        
        %randomly select a topic using z_prob distribution
        new_z = randsample(1:length(z_prob), 1, true, z_prob);
        
        z_m_n(i, j) = new_z;
        n_m_z(i, new_z) = n_m_z(i, new_z) + 1;
        n_z_t(new_z, t) = n_z_t(new_z, t) + 1;
        n_z(new_z) = n_z(new_z) + 1;
        
        %disp(new_z);
        %disp(size(test));
        %disp(size(n_z_t, 1));
        
    end
end

%disp(n_m_z);



end

