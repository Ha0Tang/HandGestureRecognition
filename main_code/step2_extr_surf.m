% Cambridge_color_9_keyframe 
clc; clear all; warning off; tic
Options.upright=true;
Options.tresh=0.0001;

feature =[];
addpath(genpath('OpenSURF_version1c')) 

imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_9entropy';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_9entropy';

subdir =  dir( imgDir );
for i = 3: length( subdir )    
    subdirpath = fullfile( imgDir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath ); 
    for j = 3 : length( subsubdirpath )
        subsubsubdirpath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name);
        images = dir( subsubsubdirpath );

        for k = 3 : length( images )
            imagepath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
            % 提取SURF特征
            iamge = imread(imagepath) ;
            Ipts=OpenSurf(iamge,Options);
            for q = 1:size(Ipts,2)
                feature = [feature; Ipts(q).descriptor'];
            end     
            savepath = fullfile(feaDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name(1:10) );   %这个（1:10）很关键
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