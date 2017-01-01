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

plot_colour(cov_training, '../pic/covtraining', 'Training Covariance');
plot_colour(cov_l2, '../pic/covl2', 'L2-Training Covariance');
plot_colour(cov_class1, '../pic/covclass1', 'Training Class 1 Covariance');
plot_colour(cov_class2, '../pic/covclass2', 'Training Class 2 Covariance');
plot_colour(cov_class3, '../pic/covclass3', 'Training Class 3 Covariance');
plot_colour(cov_l2_class1, '../pic/covl2class1', 'L2-Training Class 1 Covariance');
plot_colour(cov_l2_class2, '../pic/covl2class2', 'L2-Training Class 2 Covariance');
plot_colour(cov_l2_class3, '../pic/covl2class3', 'L2-Training Class 3 Covariance');

plot_colour(corr_training, '../pic/corrtraining', 'Training Correlation');
plot_colour(corr_l2, '../pic/corrl2', 'L2-Training Correlation');
plot_colour(corr_class1, '../pic/corrclass1', 'Training Class 1 Correlation');
plot_colour(corr_class2, '../pic/corrclass2', 'Training Class 2 Correlation');
plot_colour(corr_class3, '../pic/corrclass3', 'Training Class 3 Correlation');
plot_colour(corr_l2_class1, '../pic/corrl2class1', 'L2-Training Class 1 Correlation');
plot_colour(corr_l2_class2, '../pic/corrl2class2', 'L2-Training Class 2 Correlation');
plot_colour(corr_l2_class3, '../pic/corrl2class3', 'L2-Training Class 3 Correlation');
