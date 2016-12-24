function [ lbl ] = nearest_neighbour_l1( test_point, ...
                                      training_set, ...
                                      training_lbl )
% NEAREST_NEIGHBOUR_L1 Find nearest training point of test point.
%   Obtains L1 distance of test point to each training point.
%   Returns the class of the closest training point.
%   L1 is sum of magnitude of difference in each dimension

    % Data is in a row
    N = size(training_set, 1);
    difference = training_set(1:N, :) - test_point(ones(1,N), :);
    l1_distance = sum(abs(difference), 2);

    [~, index] = min(l1_distance);
    lbl = training_lbl(index);
end