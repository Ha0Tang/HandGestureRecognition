clc; clear all; tic
feature =[];
addpath(genpath('siftDemoV4'))
imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe_gray';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_split';
subdir =  dir( imgDir ); 
for i = 3: length( subdir )    
    subdirpath = fullfile( imgDir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath ); 
    for j = 3 : length( subsubdirpath )
        subsubsubdirpath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name);
        images = dir( subsubsubdirpath ); 

        for k = 3 : length( images )
            imagepath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
            [image,descriptors,locs] = sift(imagepath);  % Ã·»°SIFTÃÿ’˜
            feature = descriptors;
            
            savepath = fullfile(feaDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name(1:10) ); 
            if ~isdir(savepath),
                mkdir(savepath);
            end;
            save(savepath, 'feature');
            rmdir(savepath)
            feature =[];
        end
    end
end
toc