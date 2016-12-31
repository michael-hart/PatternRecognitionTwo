function [ ] = plot_colour( data, filename, title_string )
% PLOT_COLOUR Takes data, plots colour map of it, saves to disk. 
% Give title, give filename, give matrix. Easy. 
    
    % Create picture. 
    figure('position', [0 0 800 800]);
    imagesc(data);
    colorbar;
    title(title_string)
    xlabel('Dimension');
    ylabel('Dimension');
    
    % Format data
    set(findall(gcf,'type','axes'),'fontsize',30);
    set(findall(gcf,'type','text'),'fontSize',30);
    
    % Save data
    fig = gcf;
    fig.PaperPositionMode = 'auto';
    print(filename,'-dpng','-r0');

end

