% Q1, C
clear;
res_path = get_res_path();
load(strjoin({res_path 'covariances.mat'}, filesep));
load(strjoin({res_path 'means.mat'}, filesep));