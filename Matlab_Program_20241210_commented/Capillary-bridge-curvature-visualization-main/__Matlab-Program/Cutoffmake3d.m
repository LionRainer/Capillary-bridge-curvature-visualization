function[slicesurfaceplot] = slicefiguremakesurface(M_in,p);
% Create a new figure

% hold on;  % Hold the plot to add multiple lines

% Sample matrix M_GC [z, a, GC] (replace this with your actual matrix)
 Msorted = sortrows(M_in(:,[1 3 4]),1);  % Example random matrix with 150 rows
 cutoff = p/100;
if p>0
    M_GC = Msorted(round(size(Msorted,1)*cutoff):round(size(Msorted,1)*(1-cutoff)),:);
else M_GC = Msorted;
end
% Extract z, a, and GC values
z = M_GC(:, 1);
theta = M_GC(:, 2);
GC = M_GC(:, 3);

% Create a grid to interpolate the data for surf
[theta_grid, z_grid] = meshgrid(linspace(min(theta), max(theta), 50), linspace(min(z), max(z), 50));

% Interpolate GC values on the grid
GC_grid = griddata(theta, z, GC, theta_grid, z_grid, 'natural');

% Plot the surface
surf(z_grid, theta_grid, GC_grid, GC_grid, 'EdgeColor', 'k');  % Use GC_grid for coloring
colormap('winter'); % Choose a colormap (e.g., jet, parula, etc.)
colorbar; % Display color bar to show the color scale
xlabel('z');
ylabel('Theta');
zlabel('GC');
% set(gca, 'ZScale', 'log'); % Set the z-axis to logarithmic scale
% zlim([1e-6, 1e-1]); % Set z-axis limits
% Plot-Titel dynamisch mit der Variable p setzen
title(['Cutoff: ', num2str(p)]);
