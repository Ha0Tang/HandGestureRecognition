clc; clear all; tic
addpath('Gabor')
gaborArray = gaborFilterBank(5,8,39,39);  % Generates the Gabor filter bank                                
imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_5entropy';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\Gabor_feature\Northwestern_color_10_key_frames_max_5entropy';

subdir =  dir( imgDir );   % ��ȷ�����ļ���
gaborfeature =[];
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
            imagedata = imread(imagepath);
            feature = gaborFeatures(imagedata,gaborArray,48,64);   % Extracts Gabor feature vector, 'featureVector', from the image, 'img'.
            gaborfeature = [gaborfeature, feature'];
        end
        fpath = fullfile(feaDir, subdir( i ).name, subsubdirpath( j ).name);
               
        if ~isdir(fpath),
            mkdir(fpath);
        end;
        save(fpath, 'gaborfeature');
        rmdir(fpath)
        gaborfeature = []; % ����Ҫ��һ��
    end;
end
toc



