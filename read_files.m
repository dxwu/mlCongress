function [ docs, V ] = read_files( dir_name_arr )

% READ_FILES
%   m: number of documents
%   n: the number of words in the longest document
%
%   Input:
%   	dir_name_arr: a matrix where dir_name_arr(i, :) is the name of the i'th
%   	directory containing the bill texts
%
%   Return Values:
%   	docs: m x n matrix where docs(m, n) is the ID of the n'th word in the
%   	m'th document, or 0 if the m'th document has less than n words
%   	V: the size of the vocabulary (number of distinct words across all documents)


docs = [];
for j = 1:size(dir_name_arr, 1)
    docs = [docs ; read_files_in_one_dir(dir_name_arr(j,:))];
end

V = dlmread('./vocab_length.txt', ',');


end

function [docs] = read_files_in_one_dir( dir_name )
maxCount = dlmread('./maxCount.txt');
filePattern = fullfile(dir_name, '*');
processed_bills = dir(filePattern);
docs = zeros(length(processed_bills) - 2, maxCount);
i = 1;
for k = 1:length(processed_bills)
    if strcmp(processed_bills(k).name, '.') == 0 && strcmp(processed_bills(k).name, '..') == 0
        A = dlmread(strcat(dir_name, processed_bills(k).name), ',');
        docs(i, 1:length(A)) = A;
        i = i+1;
    end
end
end

