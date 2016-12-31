% Task 1, Aa, Ab, Ba, Bb. 
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

% Acquire per class training
% Class 1 split into: 39 - 7 - 13
% Class 2 split into: 47 - 8 - 16
% Class 3 split into: 32 - 5 - 11
class1_training = training(1:39, :);
class2_training = training(40:86, :);
class3_training = training(87:end, :);
class1_l2_training = l2_training(1:39, :);
class2_l2_training = l2_training(40:86, :);
class3_l2_training = l2_training(87:end, :);

% Means
mean_training = mean(training);
mean_l2 = mean(l2_training);
mean_class1 = mean(class1_training);
mean_class2 = mean(class2_training);
mean_class3 = mean(class3_training);
mean_l2_class1 = mean(class1_l2_training);
mean_l2_class2 = mean(class2_l2_training);
mean_l2_class3 = mean(class3_l2_training);

% Calculate covariance matrices. 
cov_training = cov(training);
cov_l2 = cov(l2_training);
cov_class1 = cov(class1_training);
cov_class2 = cov(class2_training);
cov_class3 = cov(class3_training);
cov_l2_class1 = cov(class1_l2_training);
cov_l2_class2 = cov(class2_l2_training);
cov_l2_class3 = cov(class3_l2_training);


% Save the resulting sets
save(strjoin({res_path 'covariances.mat'}, filesep), ...
     'cov_training', 'cov_l2', 'cov_class1', 'cov_class2', 'cov_class3', ...
     'cov_l2_class1', 'cov_l2_class2', 'cov_l2_class3');
 
% Save the resulting sets
save(strjoin({res_path 'means.mat'}, filesep), ...
     'mean_training', 'mean_l2', 'mean_class1', 'mean_class2', 'mean_class3', ...
     'mean_l2_class1', 'mean_l2_class2', 'mean_l2_class3');