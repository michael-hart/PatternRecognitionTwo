% Task 2
% K-means with:
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
load(strjoin({res_path 'q1Db.mat'}, filesep));

% 118 training, 20 validation, 40 testing.
% training, validation, testing
% All instance per row. Feature per column. 
% Column normalisation, aka per dimension
total = [training; validation; test];
l2_total = normc(total);
l2_training = l2_total(1:118, :);
l2_validation = l2_total(119:138, :);
l2_test = l2_total(139:end, :);

answers_k3_a = kmeanmetrics(training, test, l_training, 3);
answers_k3_b = kmeanmetrics(l2_training, l2_test, l_training, 3);
answers_k3_c = kmeanmetrics(g_training, g_test, l_training, 3);
answers_k3_d = kmeanmetrics(g_l2_training, g_l2_test, l_training, 3);
answers_k3_e = kmeanmetrics(g_class1_training, g_class1_test, l_training, 3);
answers_k3_f = kmeanmetrics(g_l2_class1_training, g_l2_class1_test, l_training, 3);
answers_k3_g = kmeanmetrics(g_class2_training, g_class2_test, l_training, 3);
answers_k3_h = kmeanmetrics(g_l2_class2_training, g_l2_class2_test, l_training, 3);
answers_k3_i = kmeanmetrics(g_class3_training, g_class3_test, l_training, 3);
answers_k3_j = kmeanmetrics(g_l2_class3_training, g_l2_class3_test, l_training, 3);

answers_k10_a = kmeanmetrics(training, test, l_training, 10);
answers_k10_b = kmeanmetrics(l2_training, l2_test, l_training, 10);
answers_k10_c = kmeanmetrics(g_training, g_test, l_training, 10);
answers_k10_d = kmeanmetrics(g_l2_training, g_l2_test, l_training, 10);
answers_k10_e = kmeanmetrics(g_class1_training, g_class1_test, l_training, 10);
answers_k10_f = kmeanmetrics(g_l2_class1_training, g_l2_class1_test, l_training, 10);
answers_k10_g = kmeanmetrics(g_class2_training, g_class2_test, l_training, 10);
answers_k10_h = kmeanmetrics(g_l2_class2_training, g_l2_class2_test, l_training, 10);
answers_k10_i = kmeanmetrics(g_class3_training, g_class3_test, l_training, 10);
answers_k10_j = kmeanmetrics(g_l2_class3_training, g_l2_class3_test, l_training, 10);
