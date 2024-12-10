function[sliceplot] = slicefigure(Mdata,zbot,ztop,n)

M_in = compression(Mdata,n);

colors = [linspace(0, 1, n)', linspace(1, 0, n)', zeros(n, 1)];
% lines(n);
% [linspace(0, 1, n)', zeros(n, 1), linspace(1, 0, n)'];

%Figure 1-----------------------------------------
sliceplot(1) = figure;
hold on;  % Hold the plot to add multiple lines
% Loop through each unique z value
for i = 1:n
    
    data0 = M_in{i};
    data = sortrows(data0,3);
    zval = round(mean(data(:,1)),1);
    
    % Plot the GC(a) line for the current z value
    plot(data(:,3),data(:,5),'DisplayName', [num2str(zval)], 'Color', colors(i, :));
end

title(['GC from z = ', num2str(zbot),' to ',num2str(ztop)]);
xlabel('Theta');
ylabel('GC');
legend;
xlim('auto');
ylim('auto');
hold off;




%Figure 2-----------------------------------------

sliceplot(2) = figure;
hold on;  % Hold the plot to add multiple lines

% Loop through each unique z value
for i = 1:n
    
    data0 = M_in{i};
    data = sortrows(data0,3);
    zval = round(mean(data(:,1)),1);
    
    % Plot the GC(a) line for the current z value
    plot(data(:,3),data(:,4),'DisplayName', [num2str(zval)], 'Color', colors(i, :));
end

title(['MC from z = ', num2str(zbot),' to ',num2str(ztop)]);
xlabel('Theta');
ylabel('MC');
legend;
xlim('auto');
ylim('auto');
hold off;


% 
% % Loop through each unique z value
% for i = 1:size(M_in,3)
%     
%     % Extract data for the current z value
%     data = sortrows(M_in(:,:,i),2);
%     
%     % Plot the GC(a) line for the current z value
%     plot3(data(:,1),data(:,2),data(:,3),'k');
% end
% 
% title(['z-section MC(Theta) from', num2str(zbot),'to',num2str(ztop)]);
% % Set axis labels
% xlabel('z');
% ylabel('Theta');
% zlabel('MC');
% 
% % Set axis limits
% xlim('auto');
% ylim('auto');
% zlim([-2e-3, 2e-3]);  % Set z-axis limits to specific range
% % Set the z-axis to logarithmic scale
% %set(gca, 'ZScale', 'log');
% 
% hold off;  % Release the hold on the plot