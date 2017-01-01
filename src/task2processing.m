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
load(strjoin({res_path 'kthreeresults.mat'}, filesep));
load(strjoin({res_path 'ktenresults.mat'}, filesep));
