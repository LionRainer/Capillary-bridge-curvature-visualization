function[madesubplot] = Cutoffsubplots(M_in,c_range,n,Version)

%This was once a loop. Loop Stuff has been Ctrl + R 'ed
% c_delta = c_range/NumSP;
% c_values = linspace(c_delta, c_range, NumSP);
% h = floor(sqrt(NumSP));
% madesubplot = figure;
% Schleife über die p-Werte
% for i = 1:NumSP
    % Aktuellen p-Wert setzen
c = c_range;
%     subplot(h,round(NumSP/h), i);
    if Version == 1
        Msorted = sortrows(M_in,1); 
        lowerindex = find(Msorted(:,1)> -c, 1);
        upperindex = find(Msorted(:,1)<c,1,'last');
        
        M_GC = Msorted(lowerindex:upperindex,:); 
        % Aufruf der Funktion slicefiguremakesurface mit M_GC und p
        figure;
        slicefiguremakesurface(M_GC,c,4);
        figure;
        slicefiguremakesurface(M_GC,c,5);
    end
    
    if Version == 2
        Msorted = sortrows(M_in,3);
        lowerindex = find(Msorted(:,3)> -c, 1 );
        upperindex = find(Msorted(:,3) < c, 1,'last' );
        
        M_GC = Msorted(lowerindex:upperindex,:);

        x = M_GC(:,1);
        y = M_GC(:,2);
        z = M_GC(:,3);
        MC = M_GC(:,4);
        GC = M_GC(:,5);
        
        scatter3(x,y,z,80,PointsCurvatures(:,4),'filled');
        colormap('jet'); % Choose a colormap (e.g., jet, parula, etc.)
        colorbar; % Add colorbar to show the "dim" values
        title('Mean curvature');
        axis equal;
        caxis([-0.002 0.002])
        zlabel('z');
        xlabel('x');
        ylabel('y');

        scatter3(x,y,z,80,PointsCurvatures(:,5),'filled');
        colormap('jet'); % Choose a colormap (e.g., jet, parula, etc.)
        colorbar; % Add colorbar to show the "dim" values
        title('Gaussian curvature');
        axis equal;
        caxis([-0.00002 0.00002])
        zlabel('z');
        xlabel('x');
        ylabel('y');
    end
    
    if Version == 3
        Msorted = sortrows(M_in,1); 
        lowerindex = find(Msorted(:,1)> -c, 1);
        upperindex = find(Msorted(:,1)<c,1,'last');
        
        M_GC = Msorted(lowerindex:upperindex,:); 
        
        slicefigure(M_GC,n)
     end
    % Plot-Titel dynamisch mit dem aktuellen p-Wert setzen
%     title(['Cutoff: ', num2str(c)]);
end