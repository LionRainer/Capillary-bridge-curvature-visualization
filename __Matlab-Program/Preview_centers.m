function[diameters] = Preview_centers(x,y,z,diameters,g)


    % Create figure and set to fullscreen
fig = figure('units','normalized','outerposition',[0 0 1 1]);


scatter3(x,y,z,7,[0.75 0.75 0.75],'filled');
    title('centers of z-sections');
    zlabel('z');
    xlabel('x');
    ylabel('y');
    axis equal;
    view([1, 0, 0]); % [Azimuth, Elevation] where [1, 0, 0] makes the view parallel to the x-axis
    grid on;
        % Set custom grid spacing
    ax = gca; % Get current axes
    ax.XTick = min(x):g:max(x); % Set x-axis grid spacing
    ax.YTick = min(y):g:max(y); % Set y-axis grid spacing
    ax.ZTick = min(z):g:max(z); % Set z-axis grid spacing