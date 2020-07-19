%% һ���ļ����µ�����ͼ���SIFT������ȡ
% clc; clear all;
% tic
% % ���ԭʼͼƬ�ļ����ļ���
% % original_image_dir = 'image_database/ASL-5_color';
% % original_image_dir = 'image_database/ASL-5_depth';
% % original_image_dir = 'image_database/ASL-5_color+depth_24';
% % original_image_dir = 'image_database/ASL-9_depth_26';
% 
% % ��ȡSIFT����֮�󣬴�ŵ��ļ���
% % data_dir = 'sift_feature/ASL-5_color';
% % data_dir = 'sift_feature/ASL-5_depth';
% % data_dir = 'sift_feature/ASL-5_color+depth_24';
% % data_dir = 'sift_feature/ASL-9_depth_26';
% 
% % ����SIFT������ȡ
% % ��CalculateSiftDescriptor�������޸�ͼƬ�ĸ�ʽ
% extr_sift(original_image_dir, data_dir);
% toc

%% ��ͼ���ɲ�ɫ��jpg��ת�ɻҶ�ͼ��png�����������ڶ�Ӧ���ļ�������
% clc; clear all; tic
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe_gray';
% subdir =  dir( maindir );   % ��ȷ�����ļ���
%  
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' ) || ...
%         isequal( subdir( i ).name, '..' ) || ...
%         ~subdir( i ).isdir )   % �������Ŀ¼����
%         continue;
%     end
%      
%     subdirpath = fullfile( maindir, subdir( i ).name);   
%     subsubdirpath = dir( subdirpath );
%     
%     for j = 1 : length( subsubdirpath )
%         if( isequal( subsubdirpath( j ).name, '.' ) || ...
%             isequal( subsubdirpath( j ).name, '..' ) || ...
%             ~subsubdirpath( j ).isdir )   % �������Ŀ¼����
%             continue;
%         end
%  
%         subsubsubdirpath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, '*.jpg' );
%         images = dir( subsubsubdirpath );   % ��������ļ������Һ�׺Ϊjpg���ļ�
% 
%         for k = 1 : length( images )
%             imagepath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
%             imgdata = imread( imagepath );   
%             imgdata = rgb2gray(imgdata ) ;
%             % �ȴ����ļ���
%             savepath = fullfile( feaDir, subdir( i ).name, subsubdirpath( j ).name)
%             if ~isdir(savepath),
%                 mkdir(savepath);
%             end;
%             % ��ȷ�������·��
%             newimagename = strrep(images( k ).name, 'jpg', 'png');
%             newsavepath = fullfile(savepath, newimagename);
%             imwrite(imgdata, newsavepath,'png'); 
%         end
%     end
% end
% toc

%% �����ļ����µ�����ͼ���SIFT������ȡ һ�����б���Ϊһ��mat�ļ�
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

%% �����ļ����µ�����ͼ���SIFT������ȡ һ��ͼ�񱣴�Ϊһ��mat�ļ�
% % Cambridge_color_9_keyframe ��ȡsift����
% clc; clear all; tic
% feature =[];
% addpath(genpath('siftDemoV4')) % ����siftDemoV4�еĺ����ǣ�����������ļ��е�����ǰ����Ŀ¼
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe_gray';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_split';
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
%             feature = descriptors;
%             
%             savepath = fullfile(feaDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name(1:10) );   %�����1:10���ܹؼ�
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