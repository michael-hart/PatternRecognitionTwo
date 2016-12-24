function [ lbl ] = nearest_neighbour_intersection( test_point, ...
                                      training_set, ...
                                      training_lbl, normalised )
% NEAREST_NEIGHBOUR_INTERSECTION Find nearest training point of test point.
%   Obtains intersection distance of test point to each training point.
%   Returns the class of the closest training point.
%   Intersection is sum of minimum in each dimension.
%   Unnormalised means: 

    % Data is in a row
    N = size(training_set, 1);
    minimum = min(training_set(1:N, :), test_point(ones(1,N), :));
    min_sum = sum(minimum, 2);
    sum_training = sum(training_set(1:N, :), 2);
    sum_test = sum(test_point);
    
    if normalised == 1
        distance = min_sum;
    else
        distance = 0.5 * ((min_sum ./ sum_training) + (min_sum / sum_test));
    end
    
    [~, index] = min(distance);
    lbl = training_lbl(index);
end