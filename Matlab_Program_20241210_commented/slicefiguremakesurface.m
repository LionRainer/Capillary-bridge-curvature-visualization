function[slicesurfaceplot] = slicefiguremakesurface(M_in,zbot,ztop,Ver)
% This function requires as input: M_in(5 column matrix [z r Theta MC GC]),
% zbot,ztop(z Boundaries), Version (4 for MC in the 4th col., 5 for GC)

% Extract z, Theta, and Curvature values
z = M_in(:, 1);
theta = M_in(:, 3);
MC = M_in(:, 4);
GC = M_in(:,5);

% Create a meshgrid of z and Theta so a continuous surface can be
% interpolated
[theta_grid, z_grid] = meshgrid(linspace(min(theta), max(theta)), linspace(min(z), max(z)));
    
% Interpolate MC values on the grid
MC_grid = griddata(theta, z, MC, theta_grid, z_grid, 'natural');
GC_grid = griddata(theta, z, GC, theta_grid, z_grid, 'natural');
    
if Ver == 4
    % Plot the surface
    surf(z_grid, theta_grid, MC_grid, MC_grid, 'EdgeColor', 'none');  % Use MC_grid for coloring
    colormap('jet'); % Choose a colormap (e.g., jet, parula, etc.)
    colorbar; % Display color bar to show the color scale
    xlabel('z');
    ylabel('Theta');
    ylim([0,360]);
    caxis([MC_min MC_max]); %Mean Curvature limits for the colorbar
    zlabel('MC');
    % set(gca, 'ZScale', 'log'); % Set the z-axis to logarithmic scale
    zlim([MC_min MC_max]); % Set z-axis limits
    % Plot-Titel dynamisch mit der Variable p setzen
    title(['MC from ', num2str(zbot),'to + ',num2str(ztop)]);
end
if Ver == 5
    % Plot the surface
    surf(z_grid, theta_grid, GC_grid, GC_grid, 'EdgeColor', 'none');  % Use GC_grid for coloring
    colormap('jet'); % Choose a colormap (e.g., jet, parula, etc.)
    colorbar; % Display color bar to show the color scale
    xlabel('z');
    ylabel('Theta');    
    ylim([0,360]);
    caxis([GC_min GC_max]);%GC limits for the colorbar
    zlabel('GC');
    % set(gca, 'ZScale', 'log'); % Set the z-axis to logarithmic scale
    zlim([GC_min GC_max]); % Set z-axis limits
    % Plot-Titel dynamisch mit der Variable p setzen
    title(['GC from ', num2str(zbot),'to + ',num2str(ztop)]);
end 