%0 for depth, 1 for mag
cond = 0;

if cond == 0
    cd '../Data/Depth/3K'; 
    folder = ["1d";"2d";"3d";"4d"]; 
elseif cond == 1
    cd '../Data/Mag'; 
    folder = ["800x";"1K";"3K";"15K"]; 
end

AllRadiusValues = cell(4,1);
filename = 'All_Radius_Values.csv';

%loop over folders
for i =1:4 
    curr = folder(i);
    cd(curr)
    
    %read radius file
    fileID = fopen(filename,'r');
    formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
    delimiter = ',';
    startRow = 2;

    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    
    fclose(fileID);
    
    [numrows,colnum]=size(dataArray);
    
    %assign as nummatrix to 
    AllRadiusValues(i) = mat2cell(dataArray,numrows,colnum);
    
    cd ../
end

%Need to rename
AllRadiusValues1d = [];
AllRadiusValues2d = [];
AllRadiusValues3d = [];
AllRadiusValues4d = [];

AllRadiusValues1d = AllRadiusValues{1,1};
AllRadiusValues2d = AllRadiusValues{2,1};
AllRadiusValues3d = AllRadiusValues{3,1};
AllRadiusValues4d = AllRadiusValues{4,1};

clearvars folder filename delimiter startRow formatSpec fileID dataArray ans colnum curr i numrows;