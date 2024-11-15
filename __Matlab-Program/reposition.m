function[PC,diameters] = reposition(Points,nslices)
%Repositioning algorithm for capillary bridges
% 
% Points = PointsCurvatures(:,1:3);
% nslices = 100;

% Points = PointsCurvatures(:,1:3);
% nslices = n;

%Rotation, -90° around x
% x0 = Points(:,1);
% y0 = Points(:,3);
% z0 = -Points(:,2);

x0 = Points(:,1);
y0 = Points(:,3);
z0 = -Points(:,2);

%1:n column added to keep original order
PC_unsorted = [x0-min(x0),y0-min(y0),z0-min(z0)];
PC_unsorted = [PC_unsorted, (1:size(PC_unsorted, 1)).'];

%Sorting after z value
PC_sorted = sortrows(PC_unsorted,3);
fourth_column = PC_sorted(:,4);
PC_sorted = PC_sorted(:,1:3);

%Loop to get the diameters dataset, which slices the Pointcloud in nslices
%of equal height and calculates the crossection of each slice and their 
% center and stores it
% Define the top and bottom of the point cloud
PCtop = max(PC_sorted(:,3));
PCbot = min(PC_sorted(:,3));

Slicematrix = linspace(PCbot,PCtop,nslices+1);

% Initialize diameters matrix
diameters = zeros(nslices, 4);

% Loop over each slice
for h = 1:nslices
    % Define the indices for points within the current slice
    lowerheight = Slicematrix(h);
    upperheight = Slicematrix(h+1);
    
    sliceindices = PC_sorted(:,3) >= lowerheight & PC_sorted(:,3) <= upperheight;
    
    % Get all points at this z-level
    cross_section = PC_sorted(sliceindices, :);
    
    if isempty(cross_section)
        % Skip if no points in this slice
        continue;
    end
    
    % Calculate pairwise distances using vectorized operations
    differences = permute(cross_section, [1 3 2]) - cross_section;
    distances = sqrt(sum(differences(:, :, 1:2).^2, 3)); % 2D distances
    
    % Find the maximum distance
    max_distance = max(distances(:));
    
    % Store the diameter and center coordinates
    diameters(h, 1) = max_distance;
    diameters(h, 2:4) = mean(cross_section, 1); % Coordinates of the center
end


%Loop to find the actual region of interest, the neck with the
%characteristic capillary shape
lowerind = round(0.25*size(diameters,1));
upperind = round(0.75*size(diameters,1));
centerdiam = min(diameters(lowerind:upperind,1));
centerind0 = find(diameters(lowerind:upperind,1) == centerdiam);
centerind = centerind0(1,1);
center = diameters(centerind,2:4);
disp('center diameter: ');
disp(centerdiam);

% topdiams = diameters(centerind:size(diameters,1),:);
% botdiams = diameters(1:centerind,:);
% topind = topdiams(:,1) == max(topdiams(:,1));
% botind = botdiams(:,1) == max(botdiams(:,1));
% 
% pneck = usedneckpercentage/100;
% topval = pneck*topdiams(topind,4);
% botval = pneck*botdiams(botind,4);
% neckind = diameters(:,4) >= botval & diameters(:,4) <= topval;
% 
% neck = diameters(neckind,:);

%Finding the center(The coordinates of the center of the smallest diameter)
% center = neck(find(neck(:,1) == min(neck(:,1))),2:4);

%Translated diameters dataset
% neck = [neck(:,1) (neck(:,2:4)-center)];
diameters = [diameters(:,1) (diameters(:,2:4)-center)];
%Visualization for testing
% figure;
% plot(neck(:,4),neck(:,1));
%  title('diameters along CBridge height, neck region');
%     xlabel('z');
%     ylabel('diameter');
%      ylim ([0 max(neck(:,1))]);
%      
% figure;
%  plot(diameters(:,4),diameters(:,1));
%  title('diameters along CBridge height');
%     xlabel('z');
%     ylabel('diameter');
%      ylim ([0 max(diameters(:,1))]);

%Rotated and Translated Point Cloud with original indexing in 4th col
PC_centered = [PC_sorted - center,fourth_column];

%Shuffling for original order which is needed for curvature data
PC_shuffled = sortrows(PC_centered,4);
PC = PC_shuffled(:,1:3);


