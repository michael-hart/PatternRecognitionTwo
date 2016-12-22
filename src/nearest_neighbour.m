function [ lbl ] = nearest_neighbour( test_point, ...
                                      training_set, ...
                                      training_lbl )
%NEAREST_NEIGHBOUR Find nearest training point of test point
%   Subtracts the test point from all points in training set
%   Returns the class of the closest training point

% Data is in a row
N = size(training_set, 1);
error_mat = training_set(1:N, :) - test_point(ones(1,N), :);

[~, index] = min(sum(error_mat.^2, 2));
lbl = training_lbl(index);

end