function [ answers ] = kmeanmetrics( training_data, test_data, l_training, k )
% KMEANMETRICS - Performs k means on training data, tests with all metrics
%   Training data is instance per row, same as test_data.
%   Performs kmeans and NN cluster with all 4 metrics
%   Returns 4 column matrix with answers, order:
%   Euclidean, Cityblock, Cosine, Correlation
    
    distance_types = {'sqeuclidean', 'cityblock', 'cosine', 'correlation'};
    % Initialise storage, for indices, for cluster centers, for answers.
    idx = zeros(118, 4);
    clusters = zeros(k, 13, 4);
    answers = zeros(40, 4);

    % For each type of metric
    for metric_index = 1:4
        % Perform k means
        [idx(:, metric_index), clusters(:, :, metric_index)] = ...
            kmeans(training_data, k, 'Distance', distance_types(metric_index));

        % Find which class per cluster, by most common class per cluster
        assignment = zeros(k, 1);
        % For each cluster
        for clus = 1:k
            % Indices for that cluster.
            indices = idx(:, metric_index) == clus;
            % Most common class label in those indices.
            assignment(clus) = mode(l_training(indices));
        end

        % For each test case, assign class based on nearest neighbour using
        % SAME METRIC AS CLUSTER. It makes no sense to perform it for other
        % metrics since that was not what was used to form the clusters.

        for test_index = 1:40
            answers(test_index, metric_index) = ...
                nearest_cluster(assignment, clusters(:, :, metric_index), ...
                    test_data(test_index, :), distance_types(metric_index));
        end
    end

end

