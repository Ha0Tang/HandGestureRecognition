%% Northwestern ��Ƶ��ʽ��
% clc; clear all; tic 
% addpath('3DSIFT_CODE_v1')
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_70\'; % ����70��
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10\'; % ����10��
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10\'; % ����10��
% subdir =  dir( maindir );   % ��ȷ�����ļ���
%  
% for k = 1 : length( subdir )
%     if( isequal( subdir( k ).name, '.' ) || ...
%         isequal( subdir( k ).name, '..' ) || ...
%         ~subdir( k ).isdir )   % �������Ŀ¼����
%         continue;
%     end
%      
%     subdirpath = fullfile( maindir, subdir( k ).name, '*.avi' );
%     videos = dir( subdirpath );   % ��������ļ������Һ�׺Ϊ.avi���ļ�
%      
%     % ����ÿ����Ƶ
%     for j = 1 : length( videos )
%         videopath = fullfile( maindir, subdir( k ).name, videos( j ).name  )
%         avif = VideoReader(videopath);
%         pix = double(zeros(avif.Height,avif.Width,avif.NumberOfFrames));
%         for i=1:avif.NumberOfFrames
%             frame = read(avif,i);
%             pix(:,:,i) = double(rgb2gray(frame));
%             disp(i);
%         end
%         % ����200������ĵ�
%         randPoint=200;
%         videoSize=size(pix);
%         x=videoSize(1);
%         y=videoSize(2);
%         t=videoSize(3);
%         rand_x=randi(x,randPoint,1);
%         rand_y=randi(y,randPoint,1);
%         rand_t=randi(t,randPoint,1);
%         subs =[rand_x, rand_y, rand_t];
%         
%         % Generate 200 descriptors at locations given by subs matrix
%         for i=1:randPoint
%             loc = subs(i,:);
%             fprintf(1,'Calculating keypoint at location (%d, %d, %d)\n',loc);
%             % Create a 3DSIFT descriptor at the given location
%             [keys{j, i} reRun] = Create_Descriptor(pix,1,1,loc(1),loc(2),loc(3));
%         end
%     end
%         savepath = fullfile( maindir, subdir( k ).name);
%         save(savepath, 'keys');
%         clear keys
% end
% toc

%% Northwestern ͼ�����и�ʽ��
clc; clear all; tic 
addpath('3DSIFT_CODE_v1')
% 1 ѡȡ�ؼ�֡����ֱ��ͼ�ķ�������ֵ��mean
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_mean\'; 
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_mean\';
% 2 ѡȡ�ؼ�֡���ֶ�5֡
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_frames_5keyframes\'; 
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_frames_5keyframes\';
% 3 �ؼ�ֵ��ѡȡ�ؼ�5֡
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_5entropy\'; 
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy\';
% 4 �ؼ�ֵ��ѡȡ�ؼ�5֡
maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_5entropy\'; 
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Cambridge_color_9_5entropy\';
subdir =  dir( maindir );   % ��ȷ�����ļ���
 
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )   % �������Ŀ¼����
        continue;
    end
     
    subdirpath = fullfile( maindir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath );
    
    for j = 1 : length( subsubdirpath )
        if( isequal( subsubdirpath( j ).name, '.' ) || ...
            isequal( subsubdirpath( j ).name, '..' ) || ...
            ~subsubdirpath( j ).isdir )   % �������Ŀ¼����
            continue;
        end
 
        subsubsubdirpath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, '*.jpg' );
        images = dir( subsubsubdirpath );   % ��������ļ������Һ�׺Ϊjpg���ļ�


        for k = 1 : length( images )
            imagepath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
            imgdata = imread( imagepath );   % ���������Ķ�ȡ����
            
            imgdata = rgb2gray( imgdata ); % color images, convert it to gray
        
            pix(:, :, k ) =  imgdata;
        end
        % ����200������ĵ�
        randPoint=200;
        imageSequenceSize=size(pix);
        x=imageSequenceSize(1);
        y=imageSequenceSize(2);
        t=imageSequenceSize(3);
        rand_x=randi(x,randPoint,1);
        rand_y=randi(y,randPoint,1);
        rand_t=randi(t,randPoint,1);
        subs =[rand_x, rand_y, rand_t];
        
        % Generate 200 descriptors at locations given by subs matrix
        for m=1:randPoint
            loc = subs(m,:);
            fprintf(1,'Calculating %d th class %d th sequence %d th keypoint at location (%d, %d, %d)\n',i-2,j-2,m,loc);
            % Create a 3DSIFT descriptor at the given location
            [keys{j-2, m} reRun] = Create_Descriptor(pix,1,1,loc(1),loc(2),loc(3));
        end
    end
        savepath = fullfile( feaDir, subdir( i ).name);
        if ~isdir(savepath),
            mkdir(savepath);
        end;
        save(savepath, 'keys');
        rmdir(savepath)
        clear keys
end
toc

%% Cambridge ͼ�����и�ʽ��
% clc; clear all; tic 
% addpath('3DSIFT_CODE_v1')
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9\'; % ����10��
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Cambridge_color_9\';
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9\'; % ����10��
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Cambridge_color_9\';
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
% 
%         for k = 1 : length( images )
%             imagepath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
%             imgdata = imread( imagepath );   % ���������Ķ�ȡ����
%             
%             imgdata = rgb2gray( imgdata ); % color images, convert it to gray
%         
%             pix(:, :, k ) =  imgdata;
%         end
%         % ����200������ĵ�
%         randPoint=200;
%         imageSequenceSize=size(pix);
%         x=imageSequenceSize(1);
%         y=imageSequenceSize(2);
%         t=imageSequenceSize(3);
%         rand_x=randi(x,randPoint,1);
%         rand_y=randi(y,randPoint,1);
%         rand_t=randi(t,randPoint,1);
%         subs =[rand_x, rand_y, rand_t];
%         
%         % Generate 200 descriptors at locations given by subs matrix
%         for m=1:randPoint
%             loc = subs(m,:);
%             fprintf(1,'Calculating %d th class %d th sequence %d th keypoint at location (%d, %d, %d)\n',i-2,j-2,m,loc);
%             % Create a 3DSIFT descriptor at the given location
%             [keys{j-2, m} reRun] = Create_Descriptor(pix,1,1,loc(1),loc(2),loc(3));
%         end
%     end
%         savepath = fullfile( feaDir, subdir( i ).name);
%         if ~isdir(savepath),
%             mkdir(savepath);
%         end;
%         save(savepath, 'keys');
%         rmdir(savepath)
%         clear keys
% end
% toc


