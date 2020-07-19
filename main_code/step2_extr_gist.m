clc; clear all; tic
addpath('GIST')

clear param
param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale (from HF to LF)
param.numberBlocks = 4;
param.fc_prefilt = 4;

imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_5entropy';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Northwestern_color_10_key_frames_max_5entropy';
subdir =  dir( imgDir ); 

Gistfeature =[];
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )
        continue;
    end
     
    subdirpath = fullfile( imgDir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath );
    
    for j = 1 : length( subsubdirpath )
        if( isequal( subsubdirpath( j ).name, '.' ) || ...
            isequal( subsubdirpath( j ).name, '..' ) || ...
            ~subsubdirpath( j ).isdir ) 
            continue;
        end
 
        subsubsubdirpath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, '*.jpg' )
        images = dir( subsubsubdirpath );


        for k = 1 : length( images )
            imagepath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
            img = imread( imagepath );
            % Computing gist:
            [feature, param] = LMgist(img, '', param);
            Gistfeature = [Gistfeature, feature];
        end
        fpath = fullfile(feaDir, subdir( i ).name, subsubdirpath( j ).name);
               
        if ~isdir(fpath),
            mkdir(fpath);
        end;
        save(fpath, 'Gistfeature');
        rmdir(fpath)
        Gistfeature = [];
    end;
end
toc

