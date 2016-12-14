clear
res_path = get_res_path();
load(strjoin({res_path 'wine.data.csv'}, filesep));

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

% Next is to sort data set into 118 training, 20 validation, 40 test
training = vertcat( wine_data(1:39, :), ...
                    wine_data(60:106, :), ...
                    wine_data(131:162, :) );
validation = vertcat( wine_data(40:46, :), ...
                      wine_data(107:114, :), ...
                      wine_data(163:167, :) );
test = vertcat( wine_data(47:59, :), ...
                wine_data(115:130, :), ...
                wine_data(168:178, :) );
     
% Save the resulting sets
save(strjoin({res_path 'partitioned.mat'}, filesep), 'labels', ...
                                                     'training', ...
                                                     'validation', ...
                                                     'test' );
