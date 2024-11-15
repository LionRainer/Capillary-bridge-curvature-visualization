function[sliceplot] = meanvalslicefigure(Mdata,zbot,ztop,n)

M_in = compressionCOL1(Mdata,n);

data = zeros(n,9);

for i = 1:n
    
    data0 = M_in{i};
    %dataset contains the following rows: 
%       1       2       3       4       5       6       7       8       9       
%     mean z mean GC mean MC min z  min GC  min MC    max z  max GC  max MC
    data(i,:) = [mean(data0(:,1)) mean(data0(:,5)) mean(data0(:,4)) min(data0(:,1)) min(data0(:,5)) min(data0(:,4)) max(data0(:,1)) max(data0(:,5)) max(data0(:,4))];
    
end

%Figure 1-----------------------------------------
sliceplot(1) = figure;
hold on;  % Hold the plot to add multiple lines

plot(data(:,1),data(:,2),'LineWidth',1,'Color','k')
plot(data(:,4),data(:,5),'LineWidth',0.5,'Color','g')
plot(data(:,7),data(:,8),'LineWidth',0.5,'Color','r')

title(['GC(z) from z = ', num2str(zbot),' to ',num2str(ztop), ', n = ',num2str(n)]);
xlabel('z');
ylabel('GC');
xlim('auto');
ylim([GC_min GC_max]);
hold off;


%Figure 2-----------------------------------------

sliceplot(2) = figure;
hold on;  % Hold the plot to add multiple lines
hold on;  % Hold the plot to add multiple lines

plot(data(:,1),data(:,3),'LineWidth',1,'Color','k')
plot(data(:,4),data(:,6),'LineWidth',0.5,'Color','g')
plot(data(:,7),data(:,9),'LineWidth',0.5,'Color','r')

title(['MC(z) from z = ', num2str(zbot),' to ',num2str(ztop),', n = ',num2str(n)]);
xlabel('z');
ylabel('MC');
xlim('auto');
ylim([MC_min MC_max]);
hold off;