% Q1, D, a
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

% With unmodified vectors.
% Test for L1, L2, Chi, Intersection, Corr
distances = zeros(40, 5);
for index = 1:40
    distances(index, 1) = nearest_neighbour_l1(test(index, :), training, l_training);
    distances(index, 2) = nearest_neighbour_l2(test(index, :), training, l_training);
    distances(index, 3) = nearest_neighbour_chi(test(index, :), training, l_training);
    distances(index, 4) = nearest_neighbour_corr(test(index, :), training, l_training);
    distances(index, 5) = nearest_neighbour_intersection(test(index, :), training, l_training);
end

% With l2 vectors.
% Test for L1, L2, Chi, Intersection, Corr
distances_l2 = zeros(40, 5);
for index = 1:40
    distances_l2(index, 1) = nearest_neighbour_l1(l2_test(index, :), l2_training, l_training);
    distances_l2(index, 2) = nearest_neighbour_l2(l2_test(index, :), l2_training, l_training);
    distances_l2(index, 3) = nearest_neighbour_chi(l2_test(index, :), l2_training, l_training);
    distances_l2(index, 4) = nearest_neighbour_corr(l2_test(index, :), l2_training, l_training);
    distances_l2(index, 5) = nearest_neighbour_intersection(l2_test(index, :), l2_training, l_training);
end

disp('L1, L2, Chi, Corr, Inter');
correct = distances == l_test(:, ones(5, 1));
correct_percent = sum(correct)/40 * 100;
disp('Unmodified');
disp(correct_percent);

correct_l2 = distances_l2 == l_test(:, ones(5, 1));
correct_percent_l2 = sum(correct_l2)/40 * 100;
disp('L2 Vectors');
disp(correct_percent_l2);

confusion_plotting(l_test, distances(:, 1), 'unmod_l1', 3);
confusion_plotting(l_test, distances(:, 2), 'unmod_l2', 3);
confusion_plotting(l_test, distances(:, 3), 'unmod_chi', 3);
confusion_plotting(l_test, distances(:, 4), 'unmod_corr', 3);
confusion_plotting(l_test, distances(:, 5), 'unmod_inter', 3);

confusion_plotting(l_test, distances_l2(:, 1), 'mod_l1', 3);
confusion_plotting(l_test, distances_l2(:, 2), 'mod_l2', 3);
confusion_plotting(l_test, distances_l2(:, 3), 'mod_chi', 3);
confusion_plotting(l_test, distances_l2(:, 4), 'mod_corr', 3);
confusion_plotting(l_test, distances_l2(:, 5), 'mod_inter', 3);