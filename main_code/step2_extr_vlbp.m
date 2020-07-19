clc; clear all; tic
addpath('VLBP')

%% VLBP 
%  parameter set
% "RotateIndex": 0: basic VLBP without rotation;
%                1: new Rotation invariant descriptor published in PAMI 2007;
%                2: old Rotation invariant descriptor published in ECCV
%                workshop 2006
RotateIndex = 1;

% parameter set
% 1. the radii parameter in space and Time axis; They could be 1, 2 or 3 or 4
FRadius = 1; 
TInterval = 2;

% 2. the number of the neighboring points; It can be 2 and 4.
NeighborPoints = 4;

% 3. "TimeLength" and "BorderLength" are the parameters for bordering parts in time and
% space which would not be computed for features. Usually they are same to TInterval and
% the bigger one of "FRadius";

TimeLength = 2;
BorderLength = 1;

% 4. "bBilinearInterpolation" : if use bilinear interpolation for computing a
% neighbor point in a circle: 1 (yes), 0 (not)
bBilinearInterpolation = 1;
% 1 Cambridge����ͼƬ
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9';
% 2 Cambridge�ֶ���ȡ��5���ؼ�֡
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_keyframe';
% 3 Cambridge����ǰ��ֱ֡��ͼ������ȡ�Ĺؼ�֡����ֵΪmeans
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_mean';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Northwestern_color_10_key_frames_mean';
% 4 Northwestern�ֶ���ȡ��5���ؼ�֡
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_frames_5keyframes';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Northwestern_color_10_frames_5keyframes';
% 5 Northwestern,�ز
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_entropy';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Northwestern_color_10_key_frames_entropy';
% 6 Northwestern,�ؼ�ֵ��5֡
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_5entropy';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Northwestern_color_10_key_frames_max_5entropy';
% 7 RS-HGD����ͼƬ
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\RS-HGD_color_12_frames';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\RS-HGD_color_12_frames';
% 8 RS-HGD�ؼ�ֵ��5֡
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\RS-HGD_color_12_frames_5entropy';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\RS-HGD_color_12_frames_5entropy';
% 8 cambridge�ؼ�ֵ��5֡
imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_5entropy';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_5entropy';

subdir =  dir( imgDir );   % ��ȷ�����ļ���
 
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
            
            imgdata = rgb2gray( imgdata ); % color images, convert it to gray
        
            VolData(:, :, k ) =  imgdata;
        end
        VolData = im2double( VolData );
        % call VLBP
        Histogram = RIVLBP(VolData, TInterval, FRadius, NeighborPoints, BorderLength, TimeLength, RotateIndex, bBilinearInterpolation);
        clear VolData
        
        VLBP_Feature = Histogram';    % Each row is a data instance.
        fpath = fullfile(feaDir, subdir( i ).name, subsubdirpath( j ).name);
               
        if ~isdir(fpath),
            mkdir(fpath);
        end;
        save(fpath, 'VLBP_Feature');
        rmdir(fpath)
    end;
end
toc
