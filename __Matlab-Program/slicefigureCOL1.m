function[sliceplot] = slicefigureCOL1(Mdata,zbot,ztop,n)

M_in = compressionCOL1(Mdata, n);

colors = [linspace(0, 1, n)', linspace(1, 0, n)', zeros(n, 1)];

% Figure 1-----------------------------------------
sliceplot(1) = figure;
hold on;  % Hold the plot to add multiple lines
% Loop through each unique z value
for i = 1:n
    
    data0 = M_in{i};
    data = sortrows(data0, 3);
    zval = round(mean(data(:, 1)), 1);
    
    % Plot the GC(a) line for the current z value
    plot(data(:, 3), data(:, 5), 'DisplayName', num2str(zval), 'Color', colors(i, :));
end

title(['GC(Theta) from z = ', num2str(zbot), ' to ', num2str(ztop)]);
xlabel('Theta');
ylabel('GC');
legend('show'); % Enable the interactive legend
xlim('auto');
ylim([GC_min GC_max]);
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

title(['MC(Theta) from z = ', num2str(zbot),' to ',num2str(ztop)]);
xlabel('Theta');
ylabel('MC');
legend('show');
xlim('auto');
ylim([MC_min MC_max]);
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