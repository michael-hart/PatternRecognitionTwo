clear
res_path = get_res_path();
load(strjoin({res_path 'wine.data.csv'}, filesep));

use_mixed = false;

% Wine data has several rows
% 0) Class
% 1) Alcohol
% 2) Malic acid
% 3) Ash
% 4) Alcalinity of ash
% 5) Magnesium
% 6) Total phenols
% 7) Flavanoids
% 8) Nonflavanoid phenols
% 9) Proanthocyanins
% 10)Color intensity
% 11)Hue
% 12)OD280/OD315 of diluted wines
% 13)Proline

% The wine data is therefore three CLASSES of wine, each with several
% samples

% First step is to partition class labels into a separate vector
labels = wine_data(:, 1);
wine_data = wine_data(:, 2:end);

% Class 1 is from 1 to 59
% Class 2 is from 60 to 130, offset 59, total 71
% Class 3 is from 131 to 178, offset 130, total 48

% Next is to sort data set into 118 training, 20 validation, 40 test
% Class 1 split into: 39 - 7 - 13
% Class 2 split into: 47 - 8 - 16
% Class 3 split into: 32 - 5 - 11

% Random split
order1 = randperm(59);
order2 = randperm(71) + 59;
order3 = randperm(48) + 130;
new_order = [order1 order2 order3];

% Reassign data to new order, random
mixed_wine_data = wine_data(new_order, :);
mixed_labels = labels(new_order);

if use_mixed
    wine_data = mixed_wine_data;
    labels = mixed_labels;
end

% Use mixed_wine_data and mixed_labels if you want a random selection
training = vertcat( wine_data(1:39, :), ...
                    wine_data(60:106, :), ...
                    wine_data(131:162, :) );
validation = vertcat( wine_data(40:46, :), ...
                      wine_data(107:114, :), ...
                      wine_data(163:167, :) );
test = vertcat( wine_data(47:59, :), ...
                wine_data(115:130, :), ...
                wine_data(168:178, :) );
     
l_training = vertcat( labels(1:39), labels(60:106), labels(131:162) );
l_validation = vertcat( labels(40:46), labels(107:114), labels(163:167) );
l_test = vertcat( labels(47:59), labels(115:130), labels(168:178) );

% Save the resulting sets
save(strjoin({res_path 'partitioned.mat'}, filesep), ...
     'labels', 'training', 'validation', 'test', 'l_training', ...
     'l_validation', 'l_test');
