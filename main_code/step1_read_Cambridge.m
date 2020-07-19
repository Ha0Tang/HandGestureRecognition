%%  两层文件夹下的图片的读取
clc; clear all; 
maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_9';
subdir =  dir( maindir );   % 先确定子文件夹
 
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )   % 如果不是目录跳过
        continue;
    end
     
    subdirpath = fullfile( maindir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath );
    
    for j = 1 : length( subsubdirpath )
        if( isequal( subsubdirpath( j ).name, '.' ) || ...
            isequal( subsubdirpath( j ).name, '..' ) || ...
            ~subsubdirpath( j ).isdir )   % 如果不是目录跳过
            continue;
        end
 
        subsubsubdirpath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name);
        images = dir( subsubsubdirpath );   % 在这个子文件夹下找后缀为jpg的文件


        for k = 3 : length( images )
            imagepath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
%             imgdata = imread( imagepath );   % 这里进行你的读取操作
        
        %% step1 遍历每张图片 并修改名字 前面加上文件夹的名称
%             newName = strcat( subdir( i ).name, '_', subsubdirpath( j ).name, '_', images( k ).name  )
%             newimagepath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, newName)
%             movefile(imagepath, newimagepath);

        %%  step2 移动图片
                if images( k ).name(6) == '1'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\1\');
                elseif images( k ).name(6) == '2'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\2\');
                elseif images( k ).name(6) == '3'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\3\');
                elseif images( k ).name(6) == '4'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\4\');
                elseif images( k ).name(6) == '5'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\5\');
                elseif images( k ).name(6) == '6'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\6\');
                elseif images( k ).name(6) == '7'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\7\');
                elseif images( k ).name(6) == '8'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\8\');
                elseif images( k ).name(6) == '9'
                    newimagepath = fullfile( 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge\9\');
                end
                movefile(imagepath, newimagepath);
            end
        end
end