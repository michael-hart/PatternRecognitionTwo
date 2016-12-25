function [ lbl ] = nearest_neighbour_l2( test_point, ...
                                      training_set, ...
                                      training_lbl )
% NEAREST_NEIGHBOUR_L2 Find nearest training point of test point
%   Obtains L2 distance of test point to each training point.
%   Returns the class of the closest training point.
%   L2 is square root of difference in each dimension squared

    % Data is in a row
    N = size(training_set, 1);
    difference = training_set(1:N, :) - test_point(ones(1,N), :);
    l2_distance = sum((difference .^ 2), 2);

    [~, index] = min(l2_distance);
    lbl = training_lbl(index);
end