function[madesubplot] = Visualizesection(M_in,zbot,ztop,n,Version)

%This was once a loop. Loop Stuff has been Ctrl + R 'ed
% c_delta = c_range/NumSP;
% c_values = linspace(c_delta, c_range, NumSP);
% h = floor(sqrt(NumSP));
% madesubplot = figure;
% Schleife über die p-Werte
% for i = 1:NumSP
    % Aktuellen p-Wert setzen
    
if Version ~= 2    
    M_in(:,3) = rad2deg(M_in(:,3));
end

%     subplot(h,round(NumSP/h), i);
    if Version == 4
        Msorted = sortrows(M_in,1); 
%         lowerindex = find(Msorted(:,1)> zbot, 1);
%         upperindex = find(Msorted(:,1)<ztop,1,'last');
        Mindices = Msorted(:,1)<ztop & Msorted(:,1)>zbot;
        M_GC = Msorted(Mindices,:); 
        
        % Aufruf der Funktion slicefiguremakesurface mit M_GC und p
        figure;
        slicefiguremakesurface(M_GC,zbot,ztop,4);
        figure;
        slicefiguremakesurface(M_GC,zbot,ztop,5);
    end
%     M_in = Mdatacart;
    if Version == 2
%         zbot = botval;
%         ztop = topval;
        Msorted = sortrows(M_in,3);
        Indices = Msorted(:,3)<ztop & Msorted(:,3) > zbot;
        
        M_GC = Msorted(Indices,:);

        x = M_GC(:,1);
        y = M_GC(:,2);
        z = M_GC(:,3);
        MC = M_GC(:,4);
        GC = M_GC(:,5);
        figure;
        scatter3(x,y,z,n,MC,'filled');
        colormap('jet'); % Choose a colormap (e.g., jet, parula, etc.)
        colorbar; % Add colorbar to show the "dim" values
        title('Mean curvature');
        axis equal;
        caxis([MC_min MC_max])%('auto');
        zlabel('z');
        xlabel('x');
        ylabel('y');

        figure;
        scatter3(x,y,z,n,GC,'filled');
        colormap('jet'); % Choose a colormap (e.g., jet, parula, etc.)
        colorbar; % Add colorbar to show the "dim" values
        title('Gaussian curvature');
        axis equal;
        caxis([GC_min GC_max])%('auto');%
        zlabel('z');
        xlabel('x');
        ylabel('y');
    end
    
    if Version == 1
        Msorted = sortrows(M_in,1); 
%         lowerindex = find(Msorted(:,1)> zbot, 1);
%         upperindex = find(Msorted(:,1)<ztop,1,'last');
        Mindices = Msorted(:,1)<ztop & Msorted(:,1)>zbot;
        M_GC = Msorted(Mindices,:); 
        
        slicefigureCOL1(M_GC,zbot,ztop,n);
    end
     if Version == 3
        Msorted = sortrows(M_in,1); 
        Mindices = Msorted(:,1)<ztop & Msorted(:,1)>zbot;
        M_GC = Msorted(Mindices,:);

        meanvalslicefigure(M_GC,zbot,ztop,n);
     end
    % Plot-Titel dynamisch mit dem aktuellen p-Wert setzen
%     title(['Cutoff: ', num2str(c)]);
end