% Q1, D, b
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

% Using training, test, l2_training, l2_test
% Mahalanobis distance = diff' * A * diff, A = covariance^-1
% Split A into G' * G, then apply G to all points.
% Calculate L2 distance.
% 4 covariances to use: cov_l2, cov_l2_class1, cov_l2_class2, cov_l2_class3
% Hence, take inverse of covariance, split. chol(A)=R, where R' * R = A
g = chol(inv(cov_l2));
g_class1 = chol(inv(cov_l2_class1));
g_class2 = chol(inv(cov_l2_class2));
g_class3 = chol(inv(cov_l2_class3));

% Apply transformations for unmodified
g_training = (g * training')';
g_class1_training = (g_class1 * training')';
g_class2_training = (g_class2 * training')';
g_class3_training = (g_class3 * training')';

g_test = (g * test')';
g_class1_test = (g_class1 * test')';
g_class2_test = (g_class2 * test')';
g_class3_test = (g_class3 * test')';

% Unmodified testing
distance_maha = zeros(40, 4);
for index = 1:40
    distance_maha(index, 1) = nearest_neighbour_l2(g_test(index, :), g_training, l_training);
    distance_maha(index, 2) = nearest_neighbour_l2(g_class1_test(index, :), g_class1_training, l_training);
    distance_maha(index, 3) = nearest_neighbour_l2(g_class2_test(index, :), g_class2_training, l_training);
    distance_maha(index, 4) = nearest_neighbour_l2(g_class3_test(index, :), g_class3_training, l_training);
end

% Apply transformations for unmodified
g_l2_training = (g * l2_training')';
g_l2_class1_training = (g_class1 * l2_training')';
g_l2_class2_training = (g_class2 * l2_training')';
g_l2_class3_training = (g_class3 * l2_training')';

g_l2_test = (g * test')';
g_l2_class1_test = (g_class1 * l2_test')';
g_l2_class2_test = (g_class2 * l2_test')';
g_l2_class3_test = (g_class3 * l2_test')';

% Modified testing
distance_maha_l2 = zeros(40, 4);
for index = 1:40
    distance_maha_l2(index, 1) = nearest_neighbour_l2(g_l2_test(index, :), g_l2_training, l_training);
    distance_maha_l2(index, 2) = nearest_neighbour_l2(g_l2_class1_test(index, :), g_l2_class1_training, l_training);
    distance_maha_l2(index, 3) = nearest_neighbour_l2(g_l2_class2_test(index, :), g_l2_class2_training, l_training);
    distance_maha_l2(index, 4) = nearest_neighbour_l2(g_l2_class3_test(index, :), g_l2_class3_training, l_training);
end

disp('Cov L2, Cov L2 Class 1, Cov L2 Class 2, Cov L2 Class 3');
correct = distance_maha == l_test(:, ones(4, 1));
correct_percent = sum(correct)/40 * 100;
disp('Unmodified');
disp(correct_percent);

correct_l2 = distance_maha_l2 == l_test(:, ones(4, 1));
correct_percent_l2 = sum(correct_l2)/40 * 100;
disp('L2 Vectors');
disp(correct_percent_l2);


confusion_plotting(l_test, distance_maha(:, 1), 'unmod_cov_l2', 3);
confusion_plotting(l_test, distance_maha(:, 2), 'unmod_cov_l2_class1', 3);
confusion_plotting(l_test, distance_maha(:, 3), 'unmod_cov_l2_class2', 3);
confusion_plotting(l_test, distance_maha(:, 4), 'unmod_cov_l2_class3', 3);

confusion_plotting(l_test, distance_maha_l2(:, 1), 'mod_cov_l2', 3);
confusion_plotting(l_test, distance_maha_l2(:, 2), 'mod_cov_l2_class1', 3);
confusion_plotting(l_test, distance_maha_l2(:, 3), 'mod_cov_l2_class2', 3);
confusion_plotting(l_test, distance_maha_l2(:, 4), 'mod_cov_l2_class3', 3);
