function [ label ] = nearest_cluster( classes, centroids, testpoint, distance_type )
% NEAREST_CLUSTER Using pdist(), the function selects which row of
% centroids is closest to testpoint, and assigns it the same class. 
%   classes is vector of class number relative to centroid
%   centroids is a list of row vectors, each being a centroid
%   testpoint is a vector for the test
%   distance type is either: squaredeuclidean, cityblock, cosine, or correlation

    % Confirm distance type
    if strcmp(distance_type, 'sqeuclidean')
        distance_type = 'euclidean';
    end
    
    % Acquire distances
    distances = pdist([testpoint; centroids], deblank(char(distance_type)));
    k = size(centroids, 1);
    
    % Element 1, 2, and 3 of distances are: 2-1, 3-1, 4-1 distances
    % In other words the three distances we want. 
    important_distances = distances(1:k);
    
    % Acquire minimum
    [~, index] = min(important_distances);
    % Map closest centroid to class
    label = classes(index);
end

