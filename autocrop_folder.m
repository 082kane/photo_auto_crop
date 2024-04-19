

function autocrop_folder(folder)

    files = dir(fullfile(folder, '*.jpg'));
    newFolder = fullfile(folder, "cropped")
    mkdir(newFolder);
    
    for k = 1:length(files)
        fullFileName = fullfile(folder, files(k).name);
        fprintf('Processing %s\n', fullFileName);
    
        try
            autocrop_photo(fullFileName, newFolder)
        catch ME
            disp(ME.message);

    end

    


end
