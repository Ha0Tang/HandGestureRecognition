%% �����ļ����µ�����ͼ���SIFT������ȡ һ�����б���Ϊһ��mat�ļ� (δ��)
% Cambridge_color_9_keyframe ��ȡsift����
% clc; clear all; tic
% feature =[];
% addpath(genpath('siftDemoV4')) % ����siftDemoV4�еĺ����ǣ�����������ļ��е�����ǰ����Ŀ¼
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe_gray';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_together';
% subdir =  dir( imgDir );   % ��ȷ�����ļ���
% for i = 3: length( subdir )    
%     subdirpath = fullfile( imgDir, subdir( i ).name);   
%     subsubdirpath = dir( subdirpath ); 
%     for j = 3 : length( subsubdirpath )
%         subsubsubdirpath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name);
%         images = dir( subsubsubdirpath );   % ��������ļ������Һ�׺Ϊjpg���ļ�
% 
%         for k = 3 : length( images )
%             imagepath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
%             [image,descriptors,locs] = sift(imagepath);  % ��ȡSIFT����
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

%% �����ļ����µ�����ͼ���hog������ȡ һ��ͼ�񱣴�Ϊһ��mat�ļ�
% Cambridge_color_9_keyframe 
clc; clear all; tic
hog_feature =[];
feature = [];
temp=[];
% addpath(genpath('vlfeat-0.9.20-bin')) %����matlab2014�Դ���hog������ȡ����
imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\hog_feature\Cambridge_color_9_keyframe_2_2';
subdir =  dir( imgDir );   % ��ȷ�����ļ���
for i = 3: length( subdir )    
    subdirpath = fullfile( imgDir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath ); 
    for j = 3 : length( subsubdirpath )
        subsubsubdirpath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name);
        images = dir( subsubsubdirpath );   % ��������ļ������Һ�׺Ϊjpg���ļ�

        for k = 3 : length( images )
            imagepath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ��ȡhog����
            image = imread(imagepath);
            % Apply pre-processing steps
            lvl = graythresh(image);
            image = im2bw(image, lvl);
            
            % ��Ҫ��Ĳ����ĵط�
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

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ��ȡhog����
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

        




