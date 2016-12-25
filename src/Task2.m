% Task 2
% K-means with 3 clusters

% Load data
clear;
res_path = get_res_path();
load(strjoin({res_path 'partitioned.mat'}, filesep));
load(strjoin({res_path 'covariances.mat'}, filesep));

% 118 training, 20 validation, 40 testing.
% training, validation, testing
% All instance per row. Feature per column. 
% Column normalisation, aka per dimension
total = [training; validation; test];
l2_total = normc(total);
l2_training = l2_total(1:118, :);
l2_validation = l2_total(119:138, :);
l2_test = l2_total(139:end, :);

% Define k, define distance types
k = 3;
distance_types = {'sqeuclidean', 'cityblock', 'cosine', 'correlation'};

% Initialise storage, for indices, for cluster centers, for answers.
idx = zeros(118, 4);
clusters = zeros(k, 13, 4);
answers = zeros(40, 4);

% For each type of metric
for metric_index = 1:4
    % Perform k means
    [idx(:, metric_index), clusters(:, :, metric_index)] = ...
        kmeans(training,k, 'Distance', distance_types(metric_index));
    
    % Find which class per cluster, by most common class per cluster
    assignment = zeros(k, 1);
    % For each cluster
    for clus = 1:k
        % Indices for that cluster.
        indices = find(idx(:, metric_index) == clus);
        % Most common class label in those indices.
        assignment(clus) = mode(l_training(indices));
    end
    
    % For each test case, assign class based on nearest neighbour using
    % SAME METRIC AS CLUSTER. It makes no sense to perform it for other
    % metrics since that was not what was used to form the clusters.
    
    for test_index = 1:40
        answers(test_index, metric_index) = ...
            nearest_cluster(assignment, clusters(:, :, metric_index), ...
                test(test_index, :), distance_types(metric_index));
    end
end

