%Analysis of Capillary Bridges by Lion Rainer, 06 2024
%Paris Lodron University Salzburg
%Takes data processed in ImageJ and Amira:
%   .stl file is a Pointcloud and trimesh
%   .xlsx files or similar are 
clear all
close all

savePath = uigetdir(pwd, 'Select a directory to save your figures');

% Dateiauswahl-Dialog für die STL-Datei
[stlFileName, stlPathName] = uigetfile('*.stl', 'Select the STL file');
if isequal(stlFileName, 0)
    disp('User selected Cancel');
else
    stlFullPath = fullfile(stlPathName, stlFileName);
    
    TR = stlread(stlFullPath);
end

% Dateiauswahl-Dialog für die erste CSV-Datei
[gcFileName, gcPathName] = uigetfile('*.xlsx', 'Select the first CSV file (GC)');
if isequal(gcFileName, 0)
    disp('User selected Cancel');
else
    gcFullPath = fullfile(gcPathName, gcFileName);
    GC0 = readmatrix(gcFullPath);
end

% Dateiauswahl-Dialog für die zweite CSV-Datei
[mcFileName, mcPathName] = uigetfile('*.xlsx', 'Select the second CSV file (MC)');
if isequal(mcFileName, 0)
    disp('User selected Cancel');
else
    mcFullPath = fullfile(mcPathName, mcFileName);
    MC0 = readmatrix(mcFullPath);
end

Connectivitylist = [TR.ConnectivityList MC0 GC0];
PointsCurvatures = [TR.Points,zeros(size(TR.Points,1),2)];

for i = 1:size(PointsCurvatures,1)
    %search for all indices of Connectivitylist where Point i is in the Connectivitylist
    Pointsinlist = find(Connectivitylist(:,1) == i | Connectivitylist(:,2) == i | Connectivitylist(:,3) == i ); 
    %Get first three of the indices
    Selectedpoints = Pointsinlist(1:3);
    %Get the Curvature Values at these indices which are in the 4th and 5th column 
    Curvvalues = Connectivitylist(Selectedpoints,4:5);
    %Calculate the mean Value of the three values of each Curvature (MC and
    %GC)
    Meancurvvalues = [mean(Curvvalues(:,1)) mean(Curvvalues(:,2))];
    %Enter those values to the corresponding Point Coordinates
    PointsCurvatures(i,4:5) = Meancurvvalues;
end

% PointsCurvatures = [double(TR.Points), MC0, GC0];
    
%Translate the Points such that the rotational axis is the z axis and the
%Origin is at neck height and ca. rotational center
%diameters is a nx4 matrix with center coordinates of the circular sections
%xyz in 1 2 3 column and diameter value in 1st column
n = 50;
[Pointcloud,diameters] = reposition(PointsCurvatures(:,1:3),n);
x = Pointcloud(:,1);
y = Pointcloud(:,2);
z = Pointcloud(:,3);

Preview_centers(x,y,z,diameters,round((max(z)-min(z))/40));

    % Definieren der Eingabeaufforderungen
    prompt = {'Z-Value of upper End of Neck Region:', 'Z-Value of lower End of Neck Region:'};
    dlgtitle = 'Input';
    dims = [1 35]; % Höhe und Breite der Eingabefelder
    definput = {'', ''}; % Standardmäßig leere Eingabefelder

    % Anzeigen des Eingabedialogs
    answer = inputdlg(prompt, dlgtitle, dims, definput);

    % Überprüfen, ob der Benutzer den Dialog geschlossen hat
    if ~isempty(answer)
        % Konvertieren der Eingaben in numerische Werte
        topval = str2double(answer{1});
        botval = str2double(answer{2});

        % Überprüfen, ob die Eingaben gültige Zahlen sind
        if isnan(topval) || isnan(botval)
            disp('Invalid input. Please enter numeric values.');
        else
            disp(['Z-Value of upper End of Neck Region: ', num2str(topval)]);
            disp(['Z-Value of lower End of Neck Region: ', num2str(botval)]);

            % Hier können Sie den restlichen Code einfügen, der die eingegebenen Werte verwendet
        end
    else
        disp('Dialog closed without input.');
    end

neckind = diameters(:,4) >= botval & diameters(:,4) <= topval;
neck = diameters(neckind,:);

%Previously used script for rotating the Pointcloud so the rotational Axis
%is aligned with the z-axis
% [SymPC,Symdiam] = symmetry(Pointcloud,neck);
% xrot = SymPC(:,1);
% yrot = SymPC(:,2);
% zrot = SymPC(:,3);


%Get Polar Coordinates for Visualisation
Mpolar = makepolar(Pointcloud);
Mdatapolar = [Mpolar PointsCurvatures(:,4:5)];
Mdatacart = [x y z PointsCurvatures(:,4:5)];

MC_min = -2e-3;
MC_max = 2e-3;
GC_min = -3e-5;
GC_max = 3e-5;

%Visualisation script ((nx5 Matrix with z,r,Theta,MC,GC), z-range around 
%center (+- tolerance),Number of Slices, Version...)

% 4 makes a 2,5d plot with GC and MC as the z-axis, giving an overview of
% the curvature distribution
Visualizesection(Mdatapolar,botval,topval,0,4);

% 2 = 3D Pointclouds with GC and MC Coloring
Visualizesection(Mdatacart,botval,topval,70,2);

% Version (1 = Mean and Gaussian Surface Plot (z,Theta,GC|MC)
Visualizesection(Mdatapolar,botval,topval,10,1);

% 3 = Multiplot where Data is sliced along z axis into Number of
%Slices and GC & MC are Plotted against Theta to visualize asymmetry at different heights))
Visualizesection(Mdatapolar,botval,topval,50,3);

%Visualization script, shows gray Pointcloud and colored centers of
%sections, which represent the "middle axis", colored by diameter size
Visualizecenters(x,y,z,diameters,botval,topval);

%HERE THE FIGURES ARE SAVED

NameList = readcell('NameList.xlsx');
% Get a list of all open figures
figHandles = findall(groot, 'Type', 'figure');

% Loop through each figure and save it
for i = 1:length(figHandles)
    fig = figHandles(i);
    
    % Define the file name
    fileName = NameList{i};
    
    % Full file path
    filePath = fullfile(savePath, fileName);
    
    % Save the figure
    saveas(fig, filePath, 'fig'); % You can change the format as needed
end

disp('All figures have been saved successfully.');

