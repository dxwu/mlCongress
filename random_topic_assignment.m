function [ z_m_n, n_m_z, n_z_t, n_z ] = random_topic_assignment( docs, V, K )
%RANDOM_TOPIC_ASSIGNMENT Summary of this function goes here
%   m: number of documents
%   n: the number of words in the longest document
%
%   d stands for document, w stands for word, t stands for topic
%
%   Input:
%   docs: m x n matrix where docs(m, n) is the ID of the n'th word in the
%   m'th document, or 0 if the m'th document has less than n words
%   K: the number of topics
%   V: size of vocabulary
%
%   Return Values:
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

m = size(docs, 1);
n = size(docs, 2);

z_m_n = zeros(m, n);
n_m_z = zeros(m, K);
n_z_t = zeros(K, V);
n_z = zeros(1, K);

for i = 1:m
    for j = 1:n
        %t is the id of the j'th word in document i and is used as an index into
        %the vocabulary
        t = docs(i, j);
        
        %if there are no more words in the document, continue to the next
        %document by breaking out of the inner for loop
        if t == 0
            break;
        end
        
        %randomly choose a topic for word t
        z = randi(K);
        
        z_m_n(i, j) = z;
        n_m_z(i, z) = n_m_z(i, z) + 1;
        n_z_t(z, t) = n_z_t(z, t) + 1;
        n_z(z) = n_z(z) + 1;
    end
end

end

