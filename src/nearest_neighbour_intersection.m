function [ lbl ] = nearest_neighbour_intersection( test_point, ...
                                      training_set, ...
                                      training_lbl)
% NEAREST_NEIGHBOUR_INTERSECTION Find nearest training point of test point.
%   Obtains intersection distance of test point to each training point.
%   Returns the class of the closest training point.
%   Intersection is sum of minimum in each dimension.
%   Unnormalised means: 

    % Data is in a row
    N = size(training_set, 1);
    norm_training_set = normr(training_set);
    norm_test_point = normr(test_point);
    minimum = min(norm_training_set(1:N, :), norm_test_point(ones(1,N), :));
    distance = sum(minimum, 2);
    
    [~, index] = max(distance);
    lbl = training_lbl(index);
end