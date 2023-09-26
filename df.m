openfig("3.fig");

title_font_size = 15;
axis_font_size = 15;
tick_font_size = 15;
line_width = 1;



    % Get the handle to the current figure
    h = gcf;
    
    % Get the handle to the axes of the figure
    ax = get(h, 'Children');
    
    % Loop through all axes (in case there are subplots)
    for i = 1:length(ax)
        % Get the title handle and change its FontSize
        title_handle = get(ax(i), 'Title');
        set(title_handle, 'FontSize', title_font_size);
         set(title_handle, 'String', strcat('Membrane Potential of the Input Layer: \color{red}', "No Color Circle"), 'Interpreter', 'tex');
        


        % Get the x and y label handles and change their FontSize
        xlabel_handle = get(ax(i), 'XLabel');
        ylabel_handle = get(ax(i), 'YLabel');
        set(xlabel_handle, 'FontSize', axis_font_size);
        set(ylabel_handle, 'FontSize', axis_font_size);

        % Get all line objects in the axes and change their LineWidth
        lines = findall(ax(i), 'Type', 'Line');
        for j = 1:length(lines)
            set(lines(j), 'LineWidth', line_width);
        
        end
    end

     % Check if the figure uses a tiled layout
    if isa(h.Children, 'matlab.graphics.layout.TiledChartLayout')
        % Get the handle to the axes of the tiled layout
        ax = h.Children.Children;
    else
        % Get the handle to the axes of the figure
        ax = h.Children;
    end

       for i = 1:length(ax)
        % Change the FontSize of the tick labels
        set(ax(i), 'FontSize', tick_font_size);
    end

    % Loop through all axes
    % for i = 1:length(ax)
    %     % Change the FontSize of the tick labels
    %     set(ax(i), 'FontSize', tick_font_size);
    % end
    % 
    % Determine the new filename
    
