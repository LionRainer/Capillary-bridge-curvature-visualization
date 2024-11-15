function [M_comp] = compressionCOL1(M_in, n)

% Sortiere die Eingabematrix nach der ersten Spalte
M0 = sortrows(M_in, 1);



% Bestimme das Maximum und Minimum der ersten Spalte
PCtop = max(M0(:, 1));
PCbot = min(M0(:, 1));

% Erzeuge eine Slicematrix mit n+1 Werten von PCbot bis PCtop
Slicematrix = linspace(PCbot, PCtop, n+1);

% Initialisiere ein Zellarray, um die Slice-Matrizen zu speichern
M_comp = cell(n, 1);

% Schleife über jedes Slice
for h = 1:n
    % Definiere die Indizes für die Punkte innerhalb des aktuellen Slices
    lowerheight = Slicematrix(h);
    upperheight = Slicematrix(h+1);
    
    % Indizes der Punkte innerhalb des aktuellen Slices
    sliceindices = M0(:, 1) >= lowerheight & M0(:, 1) <= upperheight;
        
    % Alle Punkte auf dieser z-Ebene
    M1 = M0(sliceindices, :);
    
    % Speichere die Punkte im Zellarray
    M_comp{h} = M1;
end


% M1 = zeros(size(M0,1),size(M0,2),n);




% c = floor(size(M0,1)/n);
% M_comp = zeros(n,4,c);
% for i = 1:c
% %     if n*i > size(M0,1)
% %         zvalue = mean(M0(n*(i-1)+1:size(M0,1),1);
% %         M_it(:,:,i) = M0(n*(i-1)+1:size(M0,1),[1 3 4 5]);
% %     else
%         zvalue = mean(M0(n*(i-1)+1:n*i,1));
%         Mz = ones(n,1)*zvalue;
%         M_it(:,1) = Mz;
%         M_it(:,2:4) = M0(n*(i-1)+1:n*i,[3 4 5]);
%         M_it = sortrows(M_it,1);
%         M_comp(:,:,i) = M_it;
% end
% 
% for i = 1:c
%     if n*i > size(M0,1)
%         M_mean(i,:) = mean(M0(n*(i-1)+1:size(M0,1),:));
%         M_median(i,:) = median(M0(n*(i-1)+1:size(M0,1),:));
%     else
%         M_mean(i,:) = mean(M0(n*(i-1)+1:n*i,:));
%         M_median(i,:) = median(M0(n*(i-1)+1:n*i,:));
%     end
% end

