clc; clear all; tic
hog_feature =[];
feature = [];
temp=[];
% addpath(genpath('vlfeat-0.9.20-bin')) 
imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\hog_feature\Cambridge_color_9_keyframe_2_2';

subdir =  dir( imgDir ); 
for i = 3: length( subdir )    
    subdirpath = fullfile( imgDir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath ); 
    for j = 3 : length( subsubdirpath )
        subsubsubdirpath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name);
        images = dir( subsubsubdirpath );   % 在这个子文件夹下找后缀为jpg的文件

        for k = 3 : length( images )
            imagepath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 提取hog特征
            image = imread(imagepath);
            % Apply pre-processing steps
            lvl = graythresh(image);
            image = im2bw(image, lvl);
            
            cellSize = [2 2]; 
            
            % Extract HOG features and HOG visualization
%             [hog_2x2, vis2x2] = extractHOGFeatures(image,'CellSize',[2 2]);
%             [hog_4x4, vis4x4] = extractHOGFeatures(image,'CellSize',[4 4]);
%             [hog_8x8, vis8x8] = extractHOGFeatures(image,'CellSize',[8 8]);
% 
%             % Visualize the HOG features
%             subplot(2,3,4);
%             plot(vis2x2);
%             title({'CellSize = [2 2]'; ['Feature length = ' num2str(length(hog_2x2))]});
% 
%             subplot(2,3,5);
%             plot(vis4x4);
%             title({'CellSize = [4 4]'; ['Feature length = ' num2str(length(hog_4x4))]});
% 
%             subplot(2,3,6);
%             plot(vis8x8);
%             title({'CellSize = [8 8]'; ['Feature length = ' num2str(length(hog_8x8))]});

            hog_feature = extractHOGFeatures(image, 'CellSize', cellSize);
            temp = [temp, hog_feature];
        end   
            feature = [feature; temp];
            hog_feature =[];
            temp=[];
    end
            savepath = fullfile(feaDir, subdir( i ).name);   
            if ~isdir(savepath),
                mkdir(savepath);
            end;
            save(savepath, 'feature');
            rmdir(savepath)
            feature = [];
end
toc

        




