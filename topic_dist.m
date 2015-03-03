function [ n_m_z ] = topic_dist( n_m_z, alpha )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

for i = 1:size(n_m_z, 1)
    n_m_z(i, :) = (n_m_z(i, :) + alpha) ./ sum(n_m_z(i, :) + alpha);
end

%disp(sum(n_m_z(11, :)));

end

