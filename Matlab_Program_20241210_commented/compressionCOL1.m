function [M_comp] = compressionCOL1(M_in, n)
%This function requires an input M_in with 5 columns: z,r,Theta,MC,GC and n
%defining the number of slices that M_in will be turned into. This function
%defines n+1 increments of equal distance along the z axis between the max
%and min z value, then makes n Matrices with the points inbetween these
%increments (z-Slices) and stores them in a cell array.

%Sort by z
M0 = sortrows(M_in, 1);



%Define z range
PCtop = max(M0(:, 1));
PCbot = min(M0(:, 1));

% Define Slice increments in z range
Slicematrix = linspace(PCbot, PCtop, n+1);

% Initialize Cell Array
M_comp = cell(n, 1);

% Loop over Slices
for h = 1:n
    % Define Borders of each slice
    lowerheight = Slicematrix(h);
    upperheight = Slicematrix(h+1);
    
    %Find indices of all Points within these borders
    sliceindices = M0(:, 1) >= lowerheight & M0(:, 1) <= upperheight;
        
    % Collect all Points of this slice
    M1 = M0(sliceindices, :);
    
    % Store Points in cell array
    M_comp{h} = M1;
end