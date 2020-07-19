%% 将图像由彩色（jpg）转成灰度图像（png），并保存在对应的文件夹下面 (未用)
% clc; clear all; tic
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe_gray';
% subdir =  dir( maindir );   % 先确定子文件夹
%  
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' ) || ...
%         isequal( subdir( i ).name, '..' ) || ...
%         ~subdir( i ).isdir )   % 如果不是目录跳过
%         continue;
%     end
%      
%     subdirpath = fullfile( maindir, subdir( i ).name);   
%     subsubdirpath = dir( subdirpath );
%     
%     for j = 1 : length( subsubdirpath )
%         if( isequal( subsubdirpath( j ).name, '.' ) || ...
%             isequal( subsubdirpath( j ).name, '..' ) || ...
%             ~subsubdirpath( j ).isdir )   % 如果不是目录跳过
%             continue;
%         end
%  
%         subsubsubdirpath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, '*.jpg' );
%         images = dir( subsubsubdirpath );   % 在这个子文件夹下找后缀为jpg的文件
% 
%         for k = 1 : length( images )
%             imagepath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
%             imgdata = imread( imagepath );   
%             imgdata = rgb2gray(imgdata ) ;
%             % 先创建文件夹
%             savepath = fullfile( feaDir, subdir( i ).name, subsubdirpath( j ).name)
%             if ~isdir(savepath),
%                 mkdir(savepath);
%             end;
%             % 再确定保存的路径
%             newimagename = strrep(images( k ).name, 'jpg', 'png');
%             newsavepath = fullfile(savepath, newimagename);
%             imwrite(imgdata, newsavepath,'png'); 
%         end
%     end
% end
% toc

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

%% 两层文件夹下的所有图像的Surf特征提取 一幅图像保存为一个mat文件
% Cambridge_color_9_keyframe 
clc; clear all; warning off; tic
% surf 参数
Options.upright=true;
Options.tresh=0.0001;

feature =[];
addpath(genpath('OpenSURF_version1c')) 
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_split';
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_3entropy';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy';
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_4entropy';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy';
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_5entropy';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy';

% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_3entropy';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_3entropy';
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_4entropy';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_4entropy';
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_5entropy';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_5entropy';
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_6entropy';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_6entropy';
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_7entropy';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_7entropy';
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_8entropy';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_8entropy';
imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_9entropy';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_9entropy';
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_5entropy_cutoff';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_5entropy_cutoff';

% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_5entropy_cutoff';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_cutoff';

subdir =  dir( imgDir );   % 先确定子文件夹
for i = 3: length( subdir )    
    subdirpath = fullfile( imgDir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath ); 
    for j = 3 : length( subsubdirpath )
        subsubsubdirpath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name);
        images = dir( subsubsubdirpath );   % 在这个子文件夹下找后缀为jpg的文件

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