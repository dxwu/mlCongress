function [pred_Y, prob_Y] = q2_predict(X, theta)
% Predict the labels and probabilities for the set of examples X using the
% model theta

% INPUT
%  X      : [m x n] matrix, where each row is an n-dimensional input example (please assume it 
%            already contains the constant feature set to 1)
%  theta  : [n x 1] vector, the model parameters used to make predictions

% OUTPUT
%  pred_Y : [m x 1] vector, the predicted labels for the examples in X
%                   note that pred_Y has binary values {0,1} in this case
%  prob_Y : [m x 1] vector, the posterior probabilities produced by the logistic function


a = -X*theta;

prob_Y = (1+exp(a)).^(-1);
m = size(prob_Y, 1);
pred_Y = zeros(m, 1);
%disp('start');
%disp([a (1+exp(a)).^(-1)]);
%disp(size(a));
%disp(size(prob_Y));
%disp(size(pred_Y));
%disp('end');
for i = 1:m
    if prob_Y(i) > 0.5
        pred_Y(i) = 1;
    end
end

end
