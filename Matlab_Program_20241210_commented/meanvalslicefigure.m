function[sliceplot] = meanvalslicefigure(Mdata,zbot,ztop,n)
%The function "meanvalslicefigure" is used to plot Curvature(z). Mdata is a
%matrix containing [z r Theta MC GC]. It calls the function
%"slicefigureCOL1" which takes M_GC between zbot and ztop and turns it into
%a cell array with n slice matrixes, each matrix having z-values within a
%certain range. The resulting cell array is then processed in a loop and
%for each of the n slice matrices. For every slice matrix, the min, mean
%and max for both GC and MC are stored, and then plotted in two figures,
%one or MC and one for GC.

%First, the input data is compressed using compressionCOL1. The result M_in
%is a cell array containing n matrices with the original 5 columns, but
%each matrix with z values within a certain range, making up a "slice".
M_in = compressionCOL1(Mdata,n);

%Initializing the data matrix which contains the data to be plotted.
data = zeros(n,9);

%Loop to extract plotting data from the cell array M_in
for i = 1:n
    %data0 is the extracted slice matrix.
    data0 = M_in{i};

    %dataset contains the following rows: 
%       1       2       3       4       5       6       7       8       9       
%     mean z mean GC mean MC mean z  min GC  min MC    mean z  max GC  max MC
    data(i,:) = [mean(data0(:,1)) mean(data0(:,5)) mean(data0(:,4)) mean(data0(:,1)) min(data0(:,5)) min(data0(:,4)) mean(data0(:,1)) max(data0(:,5)) max(data0(:,4))];
    
end

%Figure 1-----------------------------------------
sliceplot(1) = figure;
hold on;  % Hold the plot to add multiple lines
%Gaussian Curvature is plotted.
plot(data(:,1),data(:,2),'LineWidth',1,'Color','k')%meanGC
plot(data(:,4),data(:,5),'LineWidth',0.5,'Color','g')%minGC
plot(data(:,7),data(:,8),'LineWidth',0.5,'Color','r')%maxGC

title(['GC(z) from z = ', num2str(zbot),' to ',num2str(ztop), ', n = ',num2str(n)]);
xlabel('z');
ylabel('GC');
xlim('auto');
%Gaussian Curvature limits (predefined, equal for all plots)
ylim([GC_min GC_max]);
hold off;

%Figure 2-----------------------------------------
sliceplot(2) = figure;
hold on;  % Hold the plot to add multiple lines
%Mean Curvature is plotted.
plot(data(:,1),data(:,3),'LineWidth',1,'Color','k')%meanMC
plot(data(:,4),data(:,6),'LineWidth',0.5,'Color','g')%minMC
plot(data(:,7),data(:,9),'LineWidth',0.5,'Color','r')%maxMC

title(['MC(z) from z = ', num2str(zbot),' to ',num2str(ztop),', n = ',num2str(n)]);
xlabel('z');
ylabel('MC');
xlim('auto');
%Mean Curvature limits (predefined, equal for all plots)
ylim([MC_min MC_max]);
hold off;