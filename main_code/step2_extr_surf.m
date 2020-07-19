%% ��ͼ���ɲ�ɫ��jpg��ת�ɻҶ�ͼ��png�����������ڶ�Ӧ���ļ������� (δ��)
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

%% �����ļ����µ�����ͼ���Surf������ȡ һ��ͼ�񱣴�Ϊһ��mat�ļ�
% Cambridge_color_9_keyframe 
clc; clear all; warning off; tic
% surf ����
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

subdir =  dir( imgDir );   % ��ȷ�����ļ���
for i = 3: length( subdir )    
    subdirpath = fullfile( imgDir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath ); 
    for j = 3 : length( subsubdirpath )
        subsubsubdirpath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name);
        images = dir( subsubsubdirpath );   % ��������ļ������Һ�׺Ϊjpg���ļ�

        for k = 3 : length( images )
            imagepath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
            % ��ȡSURF����
            iamge = imread(imagepath) ;
            Ipts=OpenSurf(iamge,Options);
            for q = 1:size(Ipts,2)
                feature = [feature; Ipts(q).descriptor'];
            end     
            savepath = fullfile(feaDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name(1:10) );   %�����1:10���ܹؼ�
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