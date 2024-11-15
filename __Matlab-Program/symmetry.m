function[SymPC,Symdiam] = symmetry(Pointcloud,diameters)

%Repositioning algorithm for capillary bridges

%Translation to positive values, 1:n column added to keep original order
% PC_unsorted = [x0-min(x0),y0-min(y0),z0-min(z0)];
PC_unsorted = [Pointcloud, (1:size(Pointcloud, 1)).'];

%Sorting after z value
PC_sorted = sortrows(PC_unsorted,3);
fourth_column = PC_sorted(:,4);
PC_sorted = PC_sorted(:,1:3);


% Berechnung der Regressionsgerade
% Fügen Sie eine Spalte von Einsen für die Konstante hinzu
A = [diameters(:,2),diameters(:,3), ones(size(diameters, 1), 1)];
b = diameters(:, 4);
coeff = A \ b;

% Regressionsgerade: z = coeff(1)*x + coeff(2)*y + coeff(3)
disp('Regressionskoeffizienten:');
% disp(coeff);

direction = [coeff(1), coeff(2), 1];
direction = direction / norm(direction); % Normalisieren
disp(direction);
% Bestimmung des Rotationswinkels und der Rotationsachse
z_axis = [0, 0, 1];
rotation_axis = cross(direction, z_axis);
rotation_angle = acos(dot(direction, z_axis));

% Rotationsmatrix berechnen
if norm(rotation_axis) ~= 0
    rotation_axis = rotation_axis / norm(rotation_axis);
    R = axang2rotm([rotation_axis, rotation_angle]);
else
    R = eye(3); % Wenn die Vektoren parallel sind, keine Rotation
end

% Translation: Verschiebung des Mittelpunkts der Punkte zum Ursprung
% centroid = mean(points);
% points_translated = diameters(:,2:4) - centroid;
% Pointcloud_translated = Pointcloud - centroid;

% % Anwendung der Rotation
% points_rotated = (R * points_translated')';
% Pointcloud_rotated = (R * Pointcloud_translated')';

points_final = (R * diameters(:,2:4)')';
Symdiam = [diameters(:,1) points_final];
SymPC = (R * PC_sorted')';
% % % Rückübersetzung, falls notwendig
% % points_final = points_rotated + centroid;

% Visualisierung der transformierten Punkte und der Regressionsgeraden
figure;
hold on;
% scatter3(points_final(:, 1), points_final(:, 2), points_final(:, 3),50,diameters(:,1),'filled');

% t = linspace(min(points_final(:, 3)), max(points_final(:, 3)), 100);
% plot3(zeros(size(t)), zeros(size(t)), t, 'r', 'LineWidth', 2);
scatter3(SymPC(:,1),SymPC(:,2),SymPC(:,3),3,[0.5 0.5 1],'filled')

scatter3(Pointcloud(:,1),Pointcloud(:,2),Pointcloud(:,3),3,[1 0.5 0.5],'filled')

xlabel('X');
ylabel('Y');
zlabel('Z');
title('Transformierte (rot) und original (blau) Punkte');
axis equal
hold off;


% centerind = find(diameters(:,1) == min(diameters(:,1)));
% topind = centerind;
% botind = centerind;
% for i = centerind-1:-1:1
%     if diameters(i,1)<diameters(i+1,1)
%         break
%     else
%         botind = i;
%     end
% end
% 
% for i = centerind+1:size(diameters(:,1))
%     if diameters(i+1,1)<diameters(i)
%         break
%     else
%         topind = i;
%     end
% end
% neck = diameters(botind:topind,:);
% center = neck(neck(:,1) == min(neck(:,1)),2:4);
% 
% %Translated diameters dataset
% diameters = [neck(:,1) (neck(:,2:4)-center)];
% 
% %Rotated and Translated Point Cloud with original indexing in 4th col
% PC_centered = [PC_sorted - center,fourth_column];
% 
% 
% PC_shuffled = sortrows(PC_centered,4);
% PC = PC_shuffled(:,1:3);
% 
% % x = PC(:,1);
% % y = PC(:,2);
% % z = PC(:,3);

