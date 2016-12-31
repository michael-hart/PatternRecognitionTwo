% Q1, C
clear;
res_path = get_res_path();
load(strjoin({res_path 'covariances.mat'}, filesep));
load(strjoin({res_path 'means.mat'}, filesep));

corr_training = corrcov(cov_training);
corr_l2 = corrcov(cov_l2);
corr_class1 = corrcov(cov_class1);
corr_class2 = corrcov(cov_class2);
corr_class3 = corrcov(cov_class3);
corr_l2_class1 = corrcov(cov_class1);
corr_l2_class2 = corrcov(cov_class2);
corr_l2_class3 = corrcov(cov_class3);
