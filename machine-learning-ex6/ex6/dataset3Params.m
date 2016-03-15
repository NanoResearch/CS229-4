function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.03;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
C_iter = 0.01;
sigma_iter = 0.01;
iter = 6;
error = 1e8;
for i = 1:iter
    for j = 1:iter
        model= svmTrain(X, y, C_iter, @(x1, x2) gaussianKernel(x1, x2, sigma_iter));
        predictions = svmPredict(model, Xval);
        error_iter = mean(double(predictions ~= yval));
        
        if error_iter < error
            C = C_iter;
            sigma = sigma_iter;
            error = error_iter;
        end
        
        if mod(j,2) ~= 0
            sigma_iter = sigma_iter*3;
        else
            sigma_iter = sigma_iter/3*10;
        end
    end
    if mod(i,2) ~= 0
        C_iter = C_iter*3;
    else
        C_iter = C_iter/3*10;
    end
    sigma_iter = 0.01;
end

% =========================================================================

end
