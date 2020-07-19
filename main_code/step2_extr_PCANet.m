% ��ͼ�񱣴�Ϊcell��
clc; clear all; tic
addpath(genpath('PCANet'))
%% PCANet parameters (they should be funed based on validation set; i.e., ValData & ValLabel)
PCANet.NumStages = 2;
PCANet.PatchSize = [5 5];
PCANet.NumFilters = [40 8];
PCANet.HistBlockSize = [8 8];
PCANet.BlkOverLapRatio = 0.5;
PCANet.Pyramid = [4 2 1];

fprintf('\n ====== PCANet Parameters ======= \n')
PCANet

imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_5entropy';
saveDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_5entropy_cell';

subdir =  dir( imgDir );   % ��ȷ�����ļ���
keyframe = 5;
iamge_cell = cell(keyframe,1);
Feature = [];
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )   % �������Ŀ¼����
        continue;
    end
     
    subdirpath = fullfile( imgDir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath );
    
    for j = 1 : length( subsubdirpath )
        if( isequal( subsubdirpath( j ).name, '.' ) || ...
            isequal( subsubdirpath( j ).name, '..' ) || ...
            ~subsubdirpath( j ).isdir )   % �������Ŀ¼����
            continue;
        end
 
        subsubsubdirpath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, '*.jpg' )
        images = dir( subsubsubdirpath );   % ��������ļ������Һ�׺Ϊjpg���ļ�


        for k = 1 : length( images ) 
            imagepath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
            imgdata = imread( imagepath );   % ���������Ķ�ȡ����
            imgdata = im2double( imgdata );
            iamge_cell{k,1} =  imgdata;
        end
        % call PCANet_train
        [feature, V, BlkIdx] = PCANet_train(iamge_cell,PCANet,1); % BlkIdx serves the purpose of learning block-wise DR projection matrix; e.g., WPCA
        feature = feature';
        Feature = [feature(1,:),feature(2,:),feature(3,:),feature(4,:),feature(5,:)];
        clear imagedata
        
        fpath = fullfile(saveDir, subdir( i ).name, subsubdirpath( j ).name);
               
        if ~isdir(fpath),
            mkdir(fpath);
        end;
        save(fpath, 'Feature');
        rmdir(fpath)
    end;
end
toc
