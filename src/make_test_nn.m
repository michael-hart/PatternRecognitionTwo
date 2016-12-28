function [ acc, t_train, t_test, err ] = make_test_nn( training, ...
                                                       l_training, ...
                                                       test, ...
                                                       l_test, ...
                                                       validation, ...
                                                       l_validation, ...
                                                       n_hidden, ...
                                                       train_alg)
%MAKE_TEST_NN Generate, train, and test neural network with params
%   First six parameters are training, test, and validation data and labels
%   n_hidden is the number of neurons to use in the hidden layer
%   train_alg is the training algorithm to use
%   Function returns acc as the test accuracy, t_train as time to train,
%   and t_test as time to test

% Validation is part of the training set; concatenate the sets and set up
% the ratios

inputs = vertcat(training, validation)';
targets = vertcat(l_training, l_validation)';
Na = length(training);
Nb = length(validation);
N = (Na/(Na+Nb));

% Create a Fitting Network
% Possible training algorithms are as follows:
% 'trainlm', 'trainbr', 'trainbfg', 'trainrp', 'trainscg', 'traincgb', 
% 'traincgf', 'traincgp', 'trainoss', 'traingdx', 'traingdm', 'traingd'
% Can't find a way to change number of layers without modifying the net
% object directly
net = fitnet(n_hidden, train_alg);

% Disable the god damn UI window
net.trainParam.showWindow=0;

% Set divide function to contiguous
net.divideFcn = 'divideblock';

% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = N;
net.divideParam.valRatio = 1-N;
net.divideParam.testRatio = 0;

% TODO Set up number of layers to use

% Train the Network
tic();
net = train(net,inputs,targets);
t_train = toc();

% There is a standard test of network, but it partitions the data itself;
% hence, this isn't suitable. Our own test method follows.
test_inputs = test';
targets = l_test';

% Run test/validation data through network
tic();
outputs = net(test_inputs);
t_test = toc();

% Compare targets to outputs
correct = round(outputs) == targets;
acc = sum(correct) / length(targets);

% Now get squared error sum as error
error = gsubtract(outputs, targets);
err = error .^ 2;

end

