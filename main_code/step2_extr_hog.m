%% 两层文件夹下的所有图像的SIFT特征提取 一个序列保存为一个mat文件 (未用)
% Cambridge_color_9_keyframe 提取sift特征
% clc; clear all; tic
% feature =[];
% addpath(genpath('siftDemoV4')) % 调用siftDemoV4中的函数是，必须用这个文件夹当做当前工作目录
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe_gray';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_together';
% subdir =  dir( imgDir );   % 先确定子文件夹
% for i = 3: length( subdir )    
%     subdirpath = fullfile( imgDir, subdir( i ).name);   
%     subsubdirpath = dir( subdirpath ); 
%     for j = 3 : length( subsubdirpath )
%         subsubsubdirpath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name);
%         images = dir( subsubsubdirpath );   % 在这个子文件夹下找后缀为jpg的文件
% 
%         for k = 3 : length( images )
%             imagepath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
%             [image,descriptors,locs] = sift(imagepath);  % 提取SIFT特征
%             feature = [feature;descriptors];
%         end
%             savepath = fullfile(feaDir, subdir( i ).name, subsubdirpath( j ).name);   
%             if ~isdir(savepath),
%                 mkdir(savepath);
%             end;
%             save(savepath, 'feature');
%             rmdir(savepath)
%             feature =[];
%     end
% end
% toc

%% 两层文件夹下的所有图像的hog特征提取 一幅图像保存为一个mat文件
% Cambridge_color_9_keyframe 
clc; clear all; tic
hog_feature =[];
feature = [];
temp=[];
% addpath(genpath('vlfeat-0.9.20-bin')) %用了matlab2014自带的hog特征提取函数
imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\hog_feature\Cambridge_color_9_keyframe_2_2';
subdir =  dir( imgDir );   % 先确定子文件夹
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
            
            % 需要需改参数的地方
            cellSize = [2 2]; 
%             cellSize = [4 4];
%             cellSize = [8 8];
            
            % Extract HOG features and HOG visualization
%             [hog_2x2, vis2x2] = extractHOGFeatures(image,'CellSize',[2 2]);
%             [hog_4x4, vis4x4] = extractHOGFeatures(image,'CellSize',[4 4]);
%             [hog_8x8, vis8x8] = extractHOGFeatures(image,'CellSize',[8 8]);

%             % Show the original image
%             figure;
%             subplot(2,3,1:3); imshow(image);
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

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 提取hog特征
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

        




