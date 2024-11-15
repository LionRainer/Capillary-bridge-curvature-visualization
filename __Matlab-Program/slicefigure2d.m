function[sliceplot] = slicefigure(Mdata,zbot,ztop,n)

M_in = compression(Mdata,n);
% Create a new figure
sliceplot(1) = figure;
hold on;  % Hold the plot to add multiple lines

% Loop through each unique z value
for i = 1:size(M_in,3)
    
    % Extract data for the current z value
    data = sortrows(M_in(:,:,i),2);
    
    % Plot the GC(a) line for the current z value
    plot(data(:,2),data(:,4),'k');
    title(num2str(data(:,1)));
end


% Set axis labels
xlabel('z');
ylabel('Theta');
zlabel('GC');
% Set axis limits
xlim('auto');
ylim('auto');
zlim([-3e-5, 3e-5]);  % Set z-axis limits to specific range
% Set the z-axis to logarithmic scale
%set(gca, 'ZScale', 'log');

hold off;  % Release the hold on the plot




sliceplot(2) = figure;
hold on;  % Hold the plot to add multiple lines

% Loop through each unique z value
for i = 1:size(M_in,3)
    
    % Extract data for the current z value
    data = sortrows(M_in(:,:,i),2);
    
    % Plot the GC(a) line for the current z value
    plot(num2str(data(:,1)));
end

title(num2str(data(:,1)));
% Set axis labels
xlabel('z');
ylabel('Theta');
zlabel('MC');
% Set axis limits
xlim('auto');
ylim('auto');
zlim([-2e-3, 2e-3]);  % Set z-axis limits to specific range
% Set the z-axis to logarithmic scale
%set(gca, 'ZScale', 'log');

hold off;  % Release the hold on the plot