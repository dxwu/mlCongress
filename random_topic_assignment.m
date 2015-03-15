function [ docword_topic, doctopic_prevalence, topic_word_distrib, topic_distrib ] = random_topic_assignment( docs, V, K )
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

m = size(docs, 1);
n = size(docs, 2);

docword_topic = zeros(m, n);
doctopic_prevalence = zeros(m, K);
topic_word_distrib = zeros(K, V);
topic_distrib = zeros(1, K);

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
        
        docword_topic(i, j) = z;
        doctopic_prevalence(i, z) = doctopic_prevalence(i, z) + 1;
        topic_word_distrib(z, t) = topic_word_distrib(z, t) + 1;
        topic_distrib(z) = topic_distrib(z) + 1;
    end
end

end

