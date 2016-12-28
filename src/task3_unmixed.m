% This file runs various parameters for training/testing neural networks
% with STANDARD partition, NOT randomly allocated

% Load the data from generate_partitioned.m
clear;
res_path = get_res_path();
load(strjoin({res_path 'partitioned.mat'}, filesep));

% Make an array of algorithms and number of hidden neurons
hidden_neurons = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 30, 35, 40,...
                  45, 50, 60, 70, 80, 90, 100, 120, 140, 160, 180, 200,...
                  250, 300, 350];
algs = ['trainlm '; 'trainbr '; 'trainbfg'; 'trainrp '; ...
        'trainscg'; 'traincgb'; 'traincgf'; 'traincgp'; ...
        'trainoss'; 'traingdx'; 'traingdm'; 'traingd '];
training_algs = cellstr(algs);
             
% Open and write a header into results csv
csv_path = strjoin({res_path 'results.csv'}, filesep);
handle = fopen(csv_path, 'w');
headings = ['Partition Type,Training Algorithm,Hidden Neurons,'...
            'Time to Train,Time to Test,Accuracy', sprintf('\n')];
fwrite(handle, headings);
fclose(handle);

% Run through all combinations of hidden neurons and training algorithm
% Record information in CSV in this time
for ta=1:length(training_algs)
    for hn=1:length(hidden_neurons)
        alg = deblank(char(training_algs(ta)));
        [acc,t_train,t_test] = make_test_nn(training, l_training, test, ...
                                            l_test, validation, ...
                                            l_validation, ...
                                            hidden_neurons(hn), ...
                                            alg);
        disp(['Algorithm ', alg, ' with ', num2str(hidden_neurons(hn)),...
              ' took ', num2str(t_train), 's to test and ', ...
              num2str(t_test), 's to test with accuracy of ', ...
              num2str(acc*100), '%.']);
        data = ['unmixed,', alg, ',', ...
                num2str(hidden_neurons(hn)), ',', num2str(t_train), ...
                ',', num2str(t_test), ',', num2str(acc), sprintf('\n')];
        handle = fopen(csv_path, 'a');
        fwrite(handle, data);
        fclose(handle);
    end
end