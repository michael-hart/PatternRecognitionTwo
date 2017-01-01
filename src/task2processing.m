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

k_confusion_plotting(l_test, answers_k3_a, '../pic/kmeans/k3normal', 3);
k_confusion_plotting(l_test, answers_k3_b, '../pic/kmeans/k3l2', 3);
k_confusion_plotting(l_test, answers_k3_c, '../pic/kmeans/k3normalmaha', 3);
k_confusion_plotting(l_test, answers_k3_d, '../pic/kmeans/k3l2maha', 3);
k_confusion_plotting(l_test, answers_k3_e, '../pic/kmeans/k3normalmahac1', 3);
k_confusion_plotting(l_test, answers_k3_f, '../pic/kmeans/k3l2mahac1', 3);
k_confusion_plotting(l_test, answers_k3_g, '../pic/kmeans/k3normalmahac2', 3);
k_confusion_plotting(l_test, answers_k3_h, '../pic/kmeans/k3l2mahac2', 3);
k_confusion_plotting(l_test, answers_k3_i, '../pic/kmeans/k3normalmahac2', 3);
k_confusion_plotting(l_test, answers_k3_j, '../pic/kmeans/k3l2mahac3', 3);

k_confusion_plotting(l_test, answers_k10_a, '../pic/kmeans/k10normal', 3);
k_confusion_plotting(l_test, answers_k10_b, '../pic/kmeans/k10l2', 3);
k_confusion_plotting(l_test, answers_k10_c, '../pic/kmeans/k10normalmaha', 3);
k_confusion_plotting(l_test, answers_k10_d, '../pic/kmeans/k10l2maha', 3);
k_confusion_plotting(l_test, answers_k10_e, '../pic/kmeans/k10normalmahac1', 3);
k_confusion_plotting(l_test, answers_k10_f, '../pic/kmeans/k10l2mahac1', 3);
k_confusion_plotting(l_test, answers_k10_g, '../pic/kmeans/k10normalmahac2', 3);
k_confusion_plotting(l_test, answers_k10_h, '../pic/kmeans/k10l2mahac2', 3);
k_confusion_plotting(l_test, answers_k10_i, '../pic/kmeans/k10normalmahac2', 3);
k_confusion_plotting(l_test, answers_k10_j, '../pic/kmeans/k10l2mahac3', 3);
close all;