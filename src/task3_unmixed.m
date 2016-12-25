% This file runs various parameters for training/testing neural networks
% with STANDARD partition, NOT randomly allocated

% Load the data from generate_partitioned.m
clear;
res_path = get_res_path();
load(strjoin({res_path 'partitioned.mat'}, filesep));

% Train a neural network with trainlm (default), 10 hidden neurons, and
% test response
[acc,t_train,t_test] = make_test_nn(training, l_training, test, l_test, ...
                                  validation, l_validation, 10, 'trainlm');
disp(['Took ', t_train, 's to test and ', t_test, 's to test with ', ...
      'accuracy of ', acc*100, '%.']);
