% Task 2
% K-means with 3 clusters
% a is normal data
% b is l2norm data
% c is normal data mahalaonbis transformed by covariance of l2 data
% d is l2norm data mahalaonbis transformed by covariance of l2 data
% e is normal data mahalaonbis transformed by covariance of class 1 l2 data
% f is l2norm data mahalaonbis transformed by covariance of class 1 l2 data
% g is normal data mahalaonbis transformed by covariance of class 2 l2 data
% h is l2norm data mahalaonbis transformed by covariance of class 2 l2 data
% i is normal data mahalaonbis transformed by covariance of class 3 l2 data
% j is l2norm data mahalaonbis transformed by covariance of class 3 l2 data

% Load data
clear;
res_path = get_res_path();
load(strjoin({res_path 'partitioned.mat'}, filesep));

% 118 training, 20 validation, 40 testing.
% training, validation, testing
% All instance per row. Feature per column. 
% Column normalisation, aka per dimension
total = [training; validation; test];
l2_total = normc(total);
l2_training = l2_total(1:118, :);
l2_validation = l2_total(119:138, :);
l2_test = l2_total(139:end, :);

% Define k, define distance types, define what kind of data
k = 3;
distance_types = {'sqeuclidean', 'cityblock', 'cosine', 'correlation'};
training_data = training;
test_data = test;

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
                test_data(test_index, :), distance_types(metric_index));
    end
end

% Save data
save(strjoin({res_path 'task2a.mat'}, filesep), 'idx', 'clusters', 'answers');