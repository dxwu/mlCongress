function grad = q2_gradient(Xtrain, Ytrain, theta)
% Compute the gradient of the log likelihood at theta

% INPUT
%  Xtrain  : [m x n] matrix, where each row is a n-dimensional input example (assume it 
%            already contains the constant feature set to 1)
%  Ytrain  : [m x 1] vector, where the i-th element is the correct label
%                    for the i-th example
%  theta   : [n x 1] vector, the current model parameters

% OUTPUT
%  grad    : [n x 1] vector, the gradient of the log likelihood at theta

n = size(Xtrain, 2);
m = size(Xtrain, 1);
grad = zeros(n, 1);
[pred_Y, prob_Y] = q2_predict(Xtrain,theta);

for j = 1:n
    gradJ = 0;
    for i = 1:m
        gradJ = gradJ + (Ytrain(i) - prob_Y(i) ) * Xtrain(i,j);
    end
    grad(j) = gradJ;
end

end
