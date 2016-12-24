% Q1, D, a
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

% With unmodified vectors.
% Test for L1, L2, Chi, Intersection, Corr

distances = zeros(40, 5);

for index = 1:40
    distances(index, 1) = nearest_neighbour_l1(test(index, :), training, l_training);
    distances(index, 2) = nearest_neighbour_l2(test(index, :), training, l_training);
    distances(index, 3) = nearest_neighbour_chi(test(index, :), training, l_training);
    distances(index, 4) = nearest_neighbour_corr(test(index, :), training, l_training);
    distances(index, 5) = nearest_neighbour_intersection(test(index, :), training, l_training, 0);
end

