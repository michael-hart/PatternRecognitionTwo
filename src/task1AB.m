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

% Row normalisation, aka per instance
% l2_training = normr(training);
% l2_validation = normr(validation);
% l2_test = normr(test);

% Acquire per class training
% Class 1 split into: 39 - 7 - 13
% Class 2 split into: 47 - 8 - 16
% Class 3 split into: 32 - 5 - 11
class1_training = training(1:39, :);
class2_training = training(40:86, :);
class3_training = training(87:end, :);

% Means
mean_training = mean(training);
mean_l2 = mean(l2_training);
mean_class1 = mean(class1_training);
mean_class2 = mean(class2_training);
mean_class3 = mean(class3_training);

% Mean removed
% Training is 118, Class 1 39, Class 2 47, Class 3 32
A = training - mean_training(ones(118, 1), :);
A_l2 = l2_training - mean_l2(ones(118, 1), :);
A_class1 = class1_training - mean_class1(ones(39, 1), :);
A_class2 = class2_training - mean_class2(ones(47, 1), :);
A_class3 = class3_training - mean_class3(ones(32, 1), :);

% Covariance matrices training
% S = 1/N A A'
% But matrix is currently instance per row, aka transposed already
% Hence, 1/N A' A.  
cov_A = (1/118) * (A' * A);
cov_l2 = (1/118) * (A_l2' * A_l2);
cov_class1 = (1/39) * (A_class1' * A_class1);
cov_class2 = (1/47) * (A_class2' * A_class2);
cov_class3 = (1/32) * (A_class3' * A_class3);