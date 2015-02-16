function lik = q2_loglik(Xtrain, Ytrain, theta)
% Computes the log likelihood value for training data (Xtrain, Ytrain) and parameter theta

% INPUT
%  Xtrain  : [m x n] matrix, where each row is a n-dimensional input example (assume it 
%            already contains the constant feature set to 1)
%  Ytrain  : [m x 1] vector, where the i-th element is the correct label
%                    for the i-th example
%  theta   : [n x 1] vector, the current model parameters

% OUTPUT
%  lik     : [1 x 1] scalar, the computed log likelihood

[pred_Y, prob_Y] = q2_predict(Xtrain, theta);
%disp(theta);
%disp(size(Xtrain));
%disp(size(theta));

lik = 0;
%disp(size(Ytrain));
%disp(size(pred_Y));
m = length(Ytrain);
for i = 1:m
    lik = lik + log( (prob_Y(i)^(Ytrain(i))) * ((1-prob_Y(i))^(1-Ytrain(i)) ) + eps);%Ytrain(i) * log(prob_Y(i)) + (1 - Ytrain(i)) * log(1 - prob_Y(i));
end
%disp('yooo');
end
