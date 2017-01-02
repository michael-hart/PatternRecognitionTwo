function [ accuracies ] = k_confusion_plotting( actual_class, all_guessed_class, filename, num_classes )
% CONFUSION_PLOTTING Takes class labels, converts them, then plots them.
%   Input vectors of classes, column or row
% 
    N = max(size(actual_class));
    columns = {'_euc', '_cty', '_cos', '_cor'};
    
    % Create correct matrix
    actual = zeros(num_classes, N);
    for index = 1:N
        class_actual = actual_class(index);
        actual(class_actual, index) = 1;
    end;
    
    accuracies = zeros(1, 4);

    for counter = 1:4
        guess = zeros(num_classes, N);
        guessed_class = all_guessed_class(:, counter);

        for index = 1:N
            class_guess = guessed_class(index);
            guess(class_guess, index) = 1;
        end

        % Plot and save confusion matrix.
        figure('position', [0 0 800 800]);
        plotconfusion(actual, guess);

        % Format data
        set(findall(gcf,'type','axes'),'fontsize',30);
        set(findall(gcf,'type','text'),'fontSize',30);
        % Save data
        fig = gcf;
        fig.PaperPositionMode = 'auto';
        new_filename = deblank(char(strcat(filename, columns(counter))));
        print(new_filename,'-dpng','-r0');
        
        % Save data
        accuracies(counter) = sum(guessed_class == actual_class);
    end
end

