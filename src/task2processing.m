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
accuracies = zeros(20, 4);

[accuracies(1, :)] = k_confusion_plotting(l_test, answers_k3_a, '../pic/kmeans/k3normal', 3);
[accuracies(2, :)] = k_confusion_plotting(l_test, answers_k3_b, '../pic/kmeans/k3l2', 3);
[accuracies(3, :)] = k_confusion_plotting(l_test, answers_k3_c, '../pic/kmeans/k3normalmaha', 3);
[accuracies(4, :)] = k_confusion_plotting(l_test, answers_k3_d, '../pic/kmeans/k3l2maha', 3);
[accuracies(5, :)] = k_confusion_plotting(l_test, answers_k3_e, '../pic/kmeans/k3normalmahac1', 3);
[accuracies(6, :)] = k_confusion_plotting(l_test, answers_k3_f, '../pic/kmeans/k3l2mahac1', 3);
[accuracies(7, :)] = k_confusion_plotting(l_test, answers_k3_g, '../pic/kmeans/k3normalmahac2', 3);
[accuracies(8, :)] = k_confusion_plotting(l_test, answers_k3_h, '../pic/kmeans/k3l2mahac2', 3);
[accuracies(9, :)] = k_confusion_plotting(l_test, answers_k3_i, '../pic/kmeans/k3normalmahac3', 3);
[accuracies(10, :)] = k_confusion_plotting(l_test, answers_k3_j, '../pic/kmeans/k3l2mahac3', 3);

[accuracies(11, :)] = k_confusion_plotting(l_test, answers_k10_a, '../pic/kmeans/k10normal', 3);
[accuracies(12, :)] = k_confusion_plotting(l_test, answers_k10_b, '../pic/kmeans/k10l2', 3);
[accuracies(13, :)] = k_confusion_plotting(l_test, answers_k10_c, '../pic/kmeans/k10normalmaha', 3);
[accuracies(14, :)] = k_confusion_plotting(l_test, answers_k10_d, '../pic/kmeans/k10l2maha', 3);
[accuracies(15, :)] = k_confusion_plotting(l_test, answers_k10_e, '../pic/kmeans/k10normalmahac1', 3);
[accuracies(16, :)] = k_confusion_plotting(l_test, answers_k10_f, '../pic/kmeans/k10l2mahac1', 3);
[accuracies(17, :)] = k_confusion_plotting(l_test, answers_k10_g, '../pic/kmeans/k10normalmahac2', 3);
[accuracies(18, :)] = k_confusion_plotting(l_test, answers_k10_h, '../pic/kmeans/k10l2mahac2', 3);
[accuracies(19, :)] = k_confusion_plotting(l_test, answers_k10_i, '../pic/kmeans/k10normalmahac3', 3);
[accuracies(20, :)] = k_confusion_plotting(l_test, answers_k10_j, '../pic/kmeans/k10l2mahac3', 3);

close all;

% Create numbers
percentages = 100* accuracies ./ 40;
mean_percentages = mean(percentages, 2);
final = [ones(20 ,1) percentages mean_percentages];
% Save
dlmwrite(strjoin({res_path 'task2accuracy.txt'}, filesep), final, 'delimiter','&', 'precision','%.2f');