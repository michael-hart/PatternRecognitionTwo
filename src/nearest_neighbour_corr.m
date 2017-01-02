function [ lbl ] = nearest_neighbour_corr( test_point, ...
                                      training_set, ...
                                      training_lbl )
% NEAREST_NEIGHBOUR_CORR Find nearest training point of test point.
%   Obtains crosscorrelation distance of test point to each training point.
%   Returns the class of the closest training point.
%   Crosscorrelation is sum of products of elements.

    % Data is in a row
    N = size(training_set, 1);
    norm_training_set = normr(training_set);
    norm_test_point = normr(test_point);
    product = norm_training_set(1:N, :) .* norm_test_point(ones(1,N), :);
    crosscorr = sum(product, 2);

    [~, index] = max(crosscorr);
    lbl = training_lbl(index);
end