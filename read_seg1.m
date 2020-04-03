cd '../../Data/';

samples = ["1600"];
folders = ["800x";"1K";"3K";"15K"];
pos = 1;

figure()
for m = 1:length(samples)
    for j = 1:length(folders)
        
        %branch = fullfile(samples(m),folders(j),'1d','Best Segmentation');
        branch = fullfile(samples(m),folders(j),'1d'); %For SEM
        
        cd(branch)
        cd
        img = dir('*tif');
        for k = 1:length(img)
            filename = img(k).name;
            imageArray = imread(filename);
            subplot(4,5,pos)
            imshow(imageArray);  % Display image.
            pos = pos+1;
        end
        %cd ../../../../
        cd ../../../ % for SEM
    end
    pos = pos+1;
    
end