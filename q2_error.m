function error = q2_error(Y, pred_Y)
% Calculates the misclassification rate by comparing the predicted labels pred_Y to
% the true labels Y

% INPUT
%  Y     : [m x 1] vector, ground truth labels
%  pred_Y: [m x 1] vector, predicted labels

% OUTPUT
%  error : [1 x 1] scalar, misclassification rate, i.e. the number of
%  examples misclassified over the total number of examples

misclassify = 0;
m = length(Y);

for i = 1:m
    if(pred_Y(i) ~= Y(i))
        misclassify = misclassify + 1;
    end
end

error = misclassify/m;

end
