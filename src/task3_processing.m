% This file loads the output data from the neural network data generation
% scripts and processes it, finding and plotting the best/worst algorithms
% and saving figures as necessary

%% Initialisation

clear

% Load the data from csv
res_path = get_res_path();
data = readtable(strjoin({res_path 'results.csv'}, filesep));

algs = ['trainlm '; 'trainbr '; 'trainbfg'; 'trainrp '; ...
        'trainscg'; 'traincgb'; 'traincgf'; 'traincgp'; ...
        'trainoss'; 'traingdx'; 'traingdm'; 'traingd '];
training_algs = cellstr(algs);
    
% Pre-allocate variables for speed
unmix_lm = zeros(31, 6);  count_ulm = 1;
unmix_br = zeros(23, 6);  count_ubr = 1;
unmix_bfg = zeros(31, 6); count_ubfg = 1;
unmix_rp = zeros(31, 6);  count_urp = 1;
unmix_scg = zeros(31, 6); count_uscg = 1;
unmix_cgb = zeros(31, 6); count_ucgb = 1;
unmix_cgf = zeros(31, 6); count_ucgf = 1;
unmix_cgp = zeros(31, 6); count_ucgp = 1;
unmix_oss = zeros(31, 6); count_uoss = 1;
unmix_gdx = zeros(31, 6); count_ugdx = 1;
unmix_gdm = zeros(31, 6); count_ugdm = 1;
unmix_gd = zeros(31, 6);  count_ugd = 1;

mix_lm = zeros(31, 6);  count_mlm = 1;
mix_br = zeros(23, 6);  count_mbr = 1;
mix_bfg = zeros(31, 6); count_mbfg = 1;
mix_rp = zeros(31, 6);  count_mrp = 1;
mix_scg = zeros(31, 6); count_mscg = 1;
mix_cgb = zeros(31, 6); count_mcgb = 1;
mix_cgf = zeros(31, 6); count_mcgf = 1;
mix_cgp = zeros(31, 6); count_mcgp = 1;
mix_oss = zeros(31, 6); count_moss = 1;
mix_gdx = zeros(31, 6); count_mgdx = 1;
mix_gdm = zeros(31, 6); count_mgdm = 1;
mix_gd = zeros(31, 6);  count_mgd = 1;

% Dictate which variable to sort on
sort_by_var = 6;

% Set up the path to the pic folder
current_path = mfilename('fullpath');
split_path = strsplit(current_path, filesep);
root_path = split_path(1:end-2)';
pic_path = cat(1, root_path, 'pic');
pic_path = strjoin(pic_path, filesep);

%% Partitioning

% Partition data into separate variables
for i=1:height(data)
    row = data(i, :);
    wine_data = [double(row.HiddenNeurons), double(row.TimeToTrain), ...
                 double(row.TimeToTest), double(row.Accuracy), ...
                 double(row.SumSquaredError), ...
                 double(row.MeanSquaredError)];
    ptype = char(row.PartitionType);
    ta = char(row.TrainingAlgorithm);
    if strcmpi(ptype, 'unmixed')
        if strcmpi(ta, 'trainlm')
            unmix_lm(count_ulm, :) = wine_data;
            count_ulm = count_ulm + 1;
        elseif strcmpi(ta, 'trainbr')
            unmix_br(count_ubr, :) = wine_data;
            count_ubr = count_ubr + 1;
        elseif strcmpi(ta, 'trainbfg')
            unmix_bfg(count_ubfg, :) = wine_data;
            count_ubfg = count_ubfg + 1;
        elseif strcmpi(ta, 'trainrp')
            unmix_rp(count_urp, :) = wine_data;
            count_urp = count_urp + 1;
        elseif strcmpi(ta, 'trainscg')
            unmix_scg(count_uscg, :) = wine_data;
            count_uscg = count_uscg + 1;
        elseif strcmpi(ta, 'traincgb')
            unmix_cgb(count_ucgb, :) = wine_data;
            count_ucgb = count_ucgb + 1;
        elseif strcmpi(ta, 'traincgf')
            unmix_cgf(count_ucgf, :) = wine_data;
            count_ucgf = count_ucgf + 1;
        elseif strcmpi(ta, 'traincgp')
            unmix_cgp(count_ucgp, :) = wine_data;
            count_ucgp = count_ucgp + 1;
        elseif strcmpi(ta, 'trainoss')
            unmix_oss(count_uoss, :) = wine_data;
            count_uoss = count_uoss + 1;
        elseif strcmpi(ta, 'traingdx')
            unmix_gdx(count_ugdx, :) = wine_data;
            count_ugdx = count_ugdx + 1;
        elseif strcmpi(ta, 'traingdm')
            unmix_gdm(count_ugdm, :) = wine_data;
            count_ugdm = count_ugdm + 1;
        elseif strcmpi(ta, 'traingd')
            unmix_gd(count_ugd, :) = wine_data;
            count_ugd = count_ugd + 1;
        end
    elseif strcmpi(ptype, 'mixed')
        if strcmpi(ta, 'trainlm')
            mix_lm(count_mlm, :) = wine_data;
            count_mlm = count_mlm + 1;
        elseif strcmpi(ta, 'trainbr')
            mix_br(count_mbr, :) = wine_data;
            count_mbr = count_mbr + 1;
        elseif strcmpi(ta, 'trainbfg')
            mix_bfg(count_mbfg, :) = wine_data;
            count_mbfg = count_mbfg + 1;
        elseif strcmpi(ta, 'trainrp')
            mix_rp(count_mrp, :) = wine_data;
            count_mrp = count_mrp + 1;
        elseif strcmpi(ta, 'trainscg')
            mix_scg(count_mscg, :) = wine_data;
            count_mscg = count_mscg + 1;
        elseif strcmpi(ta, 'traincgb')
            mix_cgb(count_mcgb, :) = wine_data;
            count_mcgb = count_mcgb + 1;
        elseif strcmpi(ta, 'traincgf')
            mix_cgf(count_mcgf, :) = wine_data;
            count_mcgf = count_mcgf + 1;
        elseif strcmpi(ta, 'traincgp')
            mix_cgp(count_mcgp, :) = wine_data;
            count_mcgp = count_mcgp + 1;
        elseif strcmpi(ta, 'trainoss')
            mix_oss(count_moss, :) = wine_data;
            count_moss = count_moss + 1;
        elseif strcmpi(ta, 'traingdx')
            mix_gdx(count_mgdx, :) = wine_data;
            count_mgdx = count_mgdx + 1;
        elseif strcmpi(ta, 'traingdm')
            mix_gdm(count_mgdm, :) = wine_data;
            count_mgdm = count_mgdm + 1;
        elseif strcmpi(ta, 'traingd')
            mix_gd(count_mgd, :) = wine_data;
            count_mgd = count_mgd + 1;
        end
    end
end

%% Data Analysis

% For each of the arrays, find the two maximum and the two minimum
% To do this, form a matrix of structs

% Unmixed data
unmix_arr = [{unmix_lm };
             {unmix_br };
             {unmix_bfg};
             {unmix_rp };
             {unmix_scg};
             {unmix_cgb};
             {unmix_cgf};
             {unmix_cgp};
             {unmix_oss};
             {unmix_gdx};
             {unmix_gdm};
             {unmix_gd };];

% Alternative: Matrix of label/value pairs
unmix_lbls = zeros(12, 1);
unmix_lbls(:) = [min(unmix_lm (:, sort_by_var)), ...
                 min(unmix_br (:, sort_by_var)), ...
                 min(unmix_bfg(:, sort_by_var)), ...
                 min(unmix_rp (:, sort_by_var)), ...
                 min(unmix_scg(:, sort_by_var)), ...
                 min(unmix_cgb(:, sort_by_var)), ...
                 min(unmix_cgf(:, sort_by_var)), ...
                 min(unmix_cgp(:, sort_by_var)), ...
                 min(unmix_oss(:, sort_by_var)), ...
                 min(unmix_gdx(:, sort_by_var)), ...
                 min(unmix_gdm(:, sort_by_var)), ...
                 min(unmix_gd (:, sort_by_var))];
[~, unmixed_indices] = sort(unmix_lbls);

% Best two algorithms are 1 and 2 of indices
disp(['Unmixed data best algorithm is ', ...
      char(training_algs(unmixed_indices(1)))]);
disp(['Unmixed data second best algorithm is ', ...
      char(training_algs(unmixed_indices(2)))]);

disp(['Unmixed data second worst algorithm is ', ...
      char(training_algs(unmixed_indices(end-1)))]);
disp(['Unmixed data worst algorithm is ', ...
      char(training_algs(unmixed_indices(end)))]);

% Mixed data
mix_arr = [{mix_lm };
           {mix_br };
           {mix_bfg};
           {mix_rp };
           {mix_scg};
           {mix_cgb};
           {mix_cgf};
           {mix_cgp};
           {mix_oss};
           {mix_gdx};
           {mix_gdm};
           {mix_gd };];

mix_lbls = zeros(12, 1);
mix_lbls(:) = [min(mix_lm (:, sort_by_var)), ...
               min(mix_br (:, sort_by_var)), ...
               min(mix_bfg(:, sort_by_var)), ...
               min(mix_rp (:, sort_by_var)), ...
               min(mix_scg(:, sort_by_var)), ...
               min(mix_cgb(:, sort_by_var)), ...
               min(mix_cgf(:, sort_by_var)), ...
               min(mix_cgp(:, sort_by_var)), ...
               min(mix_oss(:, sort_by_var)), ...
               min(mix_gdx(:, sort_by_var)), ...
               min(mix_gdm(:, sort_by_var)), ...
               min(mix_gd (:, sort_by_var))];
[~, mixed_indices] = sort(mix_lbls);

% Best two algorithms are 1 and 2 of indices
disp(['Mixed data best algorithm is ', ...
      char(training_algs(mixed_indices(1)))]);
disp(['Mixed data second best algorithm is ', ...
      char(training_algs(mixed_indices(2)))]);

disp(['Mixed data second worst algorithm is ', ...
      char(training_algs(mixed_indices(end-1)))]);
disp(['Mixed data worst algorithm is ', ...
      char(training_algs(mixed_indices(end)))]);

%% Plot Unmixed

% We now have the order of the best/worst algorithms and the associated
% data, so it's time to look at generating some plots. We want to see the
% hidden neurons on the x-axis. Plot the best one for now.

unmix_best_alg = cell2mat(unmix_arr(unmixed_indices(1)));
unmix_second_alg = cell2mat(unmix_arr(unmixed_indices(2)));
unmix_second_worst_alg = cell2mat(unmix_arr(unmixed_indices(end-1)));
unmix_worst_alg = cell2mat(unmix_arr(unmixed_indices(end)));

figure;
xlabel('Hidden Neurons');
ylabel('Mean Square Error');
best = [unmixed_indices(1), unmixed_indices(2)];

hold on;
plot(unmix_best_alg(:, 1), unmix_best_alg(:, sort_by_var));
plot(unmix_second_alg(:, 1), unmix_second_alg(:, sort_by_var));

legend('show');
legend(training_algs(best));

ax = gca;
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.XMinorGrid = 'on';
ax.YMinorGrid = 'on';

print(strjoin({pic_path 'unmixed_best_fullrange'}, filesep), '-dpng');

% Set X limit to 100 to get interesting range
ax.XLim = [0 100];
print(strjoin({pic_path 'unmixed_best_limited'}, filesep), '-dpng');

%% Plot Mixed

mix_best_alg = cell2mat(mix_arr(mixed_indices(1)));
mix_second_alg = cell2mat(mix_arr(mixed_indices(2)));
mix_second_worst_alg = cell2mat(mix_arr(mixed_indices(end-1)));
mix_worst_alg = cell2mat(mix_arr(mixed_indices(end)));

figure;
xlabel('Hidden Neurons');
ylabel('Mean Square Error');
best = [mixed_indices(1), mixed_indices(2)];

hold on;
plot(mix_best_alg(:, 1), mix_best_alg(:, sort_by_var));
plot(mix_second_alg(:, 1), mix_second_alg(:, sort_by_var));

legend('show');
legend(training_algs(best));

ax = gca;
ax.XGrid = 'on';
ax.YGrid = 'on';
ax.XMinorGrid = 'on';
ax.YMinorGrid = 'on';

print(strjoin({pic_path 'mixed_best_fullrange'}, filesep), '-dpng');

% Set X limit to 100 to get interesting range
ax.XLim = [0 100];
print(strjoin({pic_path 'mixed_best_limited'}, filesep), '-dpng');
