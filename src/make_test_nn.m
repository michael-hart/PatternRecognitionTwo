function [ acc, t_train, t_test ] = make_test_nn( training, ...
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

% Set the inputs as concatenation of data, and targets as concatenation of
% classes
inputs = vertcat(training, validation, test)';
targets = vertcat(l_training, l_validation, l_test)';

% TODO use training algorithm, as it uses default of trainlm EVERY TIME

% Create a Fitting Network
hiddenLayerSize = n_hidden;
net = fitnet(hiddenLayerSize);

% Set up Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
 
% Train the Network
tic();
[net,tr] = train(net,inputs,targets);
t_train = toc();

% Test the Network
tic();
outputs = net(inputs);
t_test = toc();
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs);

% TODO assign an accuracy - some value from performance, perhaps?
acc = 1;

end

