%% 一层文件夹下的所有图像的SIFT特征提取
% clc; clear all;
% tic
% % 存放原始图片文件的文件夹
% % original_image_dir = 'image_database/ASL-5_color';
% % original_image_dir = 'image_database/ASL-5_depth';
% % original_image_dir = 'image_database/ASL-5_color+depth_24';
% % original_image_dir = 'image_database/ASL-9_depth_26';
% 
% % 提取SIFT特征之后，存放的文件夹
% % data_dir = 'sift_feature/ASL-5_color';
% % data_dir = 'sift_feature/ASL-5_depth';
% % data_dir = 'sift_feature/ASL-5_color+depth_24';
% % data_dir = 'sift_feature/ASL-9_depth_26';
% 
% % 进行SIFT特征提取
% % 在CalculateSiftDescriptor函数中修改图片的格式
% extr_sift(original_image_dir, data_dir);
% toc

%% 将图像由彩色（jpg）转成灰度图像（png），并保存在对应的文件夹下面
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

%% 两层文件夹下的所有图像的SIFT特征提取 一个序列保存为一个mat文件
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

%% 两层文件夹下的所有图像的SIFT特征提取 一幅图像保存为一个mat文件
% % Cambridge_color_9_keyframe 提取sift特征
% clc; clear all; tic
% feature =[];
% addpath(genpath('siftDemoV4')) % 调用siftDemoV4中的函数是，必须用这个文件夹当做当前工作目录
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe_gray';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_split';
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
%             feature = descriptors;
%             
%             savepath = fullfile(feaDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name(1:10) );   %这个（1:10）很关键
%             if ~isdir(savepath),
%                 mkdir(savepath);
%             end;
%             save(savepath, 'feature');
%             rmdir(savepath)
%             feature =[];
%         end
%     end
% end
% toc