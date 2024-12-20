function[results] = GC_compare(Mdatapolar,neck,botval,topval)
%This function calculates the average value of Gaussian Curvature on the
%top (45°-135°) and bottom (225°-315°) half within zbot and ztop and saves
%the two values together with neck diameter as GC_compare_SHXSY and a 2,5D
%plot of the areas where curvature data was used.

Thetaindegrees = Mdatapolar(:,3)*180/pi;
Mdatadegrees = Mdatapolar;
Mdatadegrees(:,3) = Thetaindegrees;
Mneck = Mdatadegrees(Mdatadegrees(:,1) > botval & Mdatadegrees(:,1) < topval, :);
Ttb = 45;%Theta Topside Bottomvalue
Ttt = 135;
Tbb = 225;
Tbt = 315;

Mtop = Mneck(Mneck(:,3)>Ttb&Mneck(:,3)<Ttt,:);
GC_top = mean(Mtop(:,5));
Mbot = Mneck(Tbb<Mneck(:,3)&Mneck(:,3)<Tbt,:);
GC_bot = mean(Mbot(:,5));
neckdiam = neck((neck(:,1)==min(neck(:,1))),1);
results = [GC_top GC_bot neckdiam(1)];

slicefiguremakesurfacenolimits([Mtop;Mbot],botval,topval,5);

% Prompt user for sample name
sampleName = input('Enter the sample name (e.g., ''SH1S1''): ', 's');
%Prompt user for filePath
filePath = input('Enter the file path (e.g., ''sample_data.csv''): ', 's');

newEntry = {sampleName, GC_top, GC_bot, neckdiam(1)};

if isfile(filePath)
        % If the file exists, append the new entry
        existingData = readtable(filePath, 'FileType', 'text');
        newData = [existingData; cell2table(newEntry, 'VariableNames', {'Sample', 'GC_top', 'GC_bot', 'Neckdiam'})];
        writetable(newData, filePath);
    else
        % If the file does not exist, create it with headers
        writetable(cell2table(newEntry, 'VariableNames', {'Sample', 'GC_top', 'GC_bot', 'Neckdiam'}), filePath);
    end
end
