clc; clear all; tic
addpath('LBP')
% lbp 参数
mapping = getmapping(8,'ri');
%       'u2'   for uniform LBP
%       'ri'   for rotation-invariant LBP
%       'riu2' for uniform rotation-invariant LBP.
                                
imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe_riu2';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe_ri';
subdir =  dir( imgDir );   % 先确定子文件夹
lbpfeature =[];
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )   % 如果不是目录跳过
        continue;
    end
     
    subdirpath = fullfile( imgDir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath );
    
    for j = 1 : length( subsubdirpath )
        if( isequal( subsubdirpath( j ).name, '.' ) || ...
            isequal( subsubdirpath( j ).name, '..' ) || ...
            ~subsubdirpath( j ).isdir )   % 如果不是目录跳过
            continue;
        end
 
        subsubsubdirpath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, '*.jpg' )
        images = dir( subsubsubdirpath );   % 在这个子文件夹下找后缀为jpg的文件
        for k = 1 : length( images )
            imagepath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
            imagedata = imread(imagepath);
            feature=lbp(imagedata,1,8,mapping,'h'); 
            lbpfeature = [lbpfeature, feature];
        end
        fpath = fullfile(feaDir, subdir( i ).name, subsubdirpath( j ).name);
               
        if ~isdir(fpath),
            mkdir(fpath);
        end;
        save(fpath, 'lbpfeature');
        rmdir(fpath)
        lbpfeature = []; % 很重要的一步
    end;
end
toc

