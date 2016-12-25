function [ ] = confusion_plotting( actual_class, guessed_class, filename, num_classes )
% CONFUSION_PLOTTING Takes class labels, converts them, then plots them.
%   Input vectors of classes, column or row
% 
    N = max(size(actual_class));
    actual = zeros(num_classes, N);
    guess = zeros(num_classes, N);
    
    for index = 1:N
        class_guess = guessed_class(index);
        class_actual = actual_class(index);
        actual(class_actual, index) = 1;
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
    print(filename,'-dpng','-r0');

end

