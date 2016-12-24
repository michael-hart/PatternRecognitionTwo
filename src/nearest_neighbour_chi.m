function [ lbl ] = nearest_neighbour_chi( test_point, ...
                                      training_set, ...
                                      training_lbl )
% NEAREST_NEIGHBOUR_CHI Find nearest training point of test point.
%   Obtains chi squared distance of test point to each training point.
%   Returns the class of the closest training point.
%   Chi squared is half of sum of difference in each dimension squared
%           divided by their sum.

    % Data is in a row
    N = size(training_set, 1);
    difference = training_set(1:N, :) - test_point(ones(1,N), :);
    sum_of = training_set(1:N, :) + test_point(ones(1,N), :);
    fraction = (difference .^2) ./ sum_of;
    chi_squared = 0.5 * sum(fraction, 2);
    
    [~, index] = min(chi_squared);
    lbl = training_lbl(index);
end