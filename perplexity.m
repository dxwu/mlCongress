function [ p ] = perplexity( n_m_z, z_t, docs, K, alpha )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%z_t is a word distribution (K x V) where the sum of each row is 1

logperp = 0;
Ntot = 0; %Ntot is total number of words across all documents

for m = 1:size(docs, 1)
    N = sum(docs(m,:)~=0);
    theta = n_m_z(m, :) / (N + K * alpha);
    %disp(sum(theta));
    %disp('hi');
    for n = 1:N
        logperp = logperp - log(theta * z_t(:, docs(m, n)));
    end
    Ntot = Ntot + N;
end

p = exp(logperp / Ntot);

%perplexity = zeros(K, size(z_t, 2));

%disp(size(perplexity));

%output_args = 1;

end

