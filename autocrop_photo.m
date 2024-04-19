% random info -
% using imread on jpg produces m x n x 3 matrix
% m (rows), n (columns), 3 ( 1x3 / RGB values)
% pure white = (255, 255, 255) or summed together (765)

function autocrop_photo(filename,output_dir)
    tic;
    img = imread(filename);

    % Creates two variables, equaling dimmensions of photo
    num_rows = size(img,1);
    num_columns = size(img,2);
    perfect_white_col = num_rows * 765;
    perfect_white_row = num_columns * 765;
    
    fuzzy_white = perfect_white_col * .97 ;
    white_column = fuzzy_white;
    
    left_count = 1;
    right_count = 1;
    top_count = 1;
    bottom_count =1;
    
    % Deletes Left Column Border
    col_rgb_val = sum(sum(img(:,1,[1 1 3])));
    while col_rgb_val >= white_column
        left_count = left_count + 1;
        col_rgb_val = sum(sum(img(:,left_count,[1 1 3])));
    end
    
    % Deletes Right Column Border
    col_rgb_val = sum(sum(img(:,end,[1 1 3])));
    while col_rgb_val >= white_column
        col_rgb_val = sum(sum(img(:,end-right_count,[1 1 3])));
        right_count = right_count + 1;
        
    end
    
    fuzzy_white = perfect_white_row * .97;
    white_row = fuzzy_white;
    
    % Delete Top Row Border
    row_rgb_val = sum(sum(img(1,:,[1 1 3])));
    while row_rgb_val >= white_row
        top_count = top_count + 1;
        row_rgb_val = sum(sum(img(top_count,:,[1 1 3])));
    end
    
    
    % Delete Bottom Row Border
    row_rgb_val = sum(sum(img(end,:,[1 1 3])));
    while row_rgb_val >= white_row
        row_rgb_val = sum(sum(img(end-bottom_count,:,[1 1 3])));
        bottom_count = bottom_count + 1;
    end
    
    img(:,1:left_count,:) = [];
    img(:,end-right_count:end,:) = [];
    img(1:top_count,:,:) = [];
    img(end-bottom_count:end,:,:) = [];
    
    
    %{
    %}
    
    [filepath,name,ext] = fileparts(filename);
    fullName = ['cropped_',name, ext];
    outputfile = fullfile(output_dir,fullName);
    imwrite(img,outputfile);
    
    elapsedTime = toc;
    disp(['Elapsed Time: ', num2str(elapsedTime), ' seconds']);
end



%{ 
% TEST VALUES ============
A = imread("input\raw_img.jpg");

% Creates two variables, equaling dimmensions of photo
[num_rows, num_columns] = size(A);
white_column = num_rows * 765;

% Returns SUM of RGB Values at Collumn 1
col_sum = sum(sum(A(:,1,[1 1 3])))

% Returns SUM of RGB values at pixel (1,1)
pixel_sum = sum(A(1,1,[1 1 3]));

% Delete column 1 from m x n x 3 matrix  
%A(:, 1,:) = [];

%}
