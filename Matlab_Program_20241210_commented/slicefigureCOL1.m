function[sliceplot] = slicefigureCOL1(Mdata,zbot,ztop,n)
%This function requires an input M_in with 5 columns: z,r,Theta,MC,GC and z
%Borders and n (number of slices) The function "slicefigureCOL1" is used to
%plot Curvature(Theta). It calls the function "compressionCOL1" which takes
%M_GC between zbot and ztop and turns it into a cell array with n slice
%matrixes, each matrix having z-values within a certain range. The
%resulting cell array is then processed in a loop and for each of the n
%slice matrices, n plots are made in the same figure of Curvature(Theta).
%Two figures are made, one or MC and one for GC.

%First, the input data is compressed using compressionCOL1. The result M_in
%is a cell array containing n matrices with the original 5 columns, but
%each matrix with z values within a certain range, making up a "slice".
M_in = compressionCOL1(Mdata, n);

%n amount of color values are created between green and red.
colors = [linspace(0, 1, n)', linspace(1, 0, n)', zeros(n, 1)];

% Figure 1-----------------------------------------
sliceplot(1) = figure;
hold on;  % Hold the plot to add multiple lines
% Loop through each unique z value, making n plots, one for each slice.
for i = 1:n
    %data0 is the extracted slice matrix.
    data0 = M_in{i};
    %Sort data by Theta
    data = sortrows(data0, 3);
    %Get z value of this slice
    zval = round(mean(data(:, 1)), 1);
    
    % Plot the GC(Theta) line for the current z value
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
    
    % Plot the MC(Theta) line for the current z value
    plot(data(:,3),data(:,4),'DisplayName', [num2str(zval)], 'Color', colors(i, :));
end

title(['MC(Theta) from z = ', num2str(zbot),' to ',num2str(ztop)]);
xlabel('Theta');
ylabel('MC');
legend('show');
xlim('auto');
ylim([MC_min MC_max]);
hold off;