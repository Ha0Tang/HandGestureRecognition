clc; clear all; tic 
addpath('3DSIFT_CODE_v1')

maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_5entropy\'; 
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Cambridge_color_9_5entropy\';
subdir =  dir( maindir );
 
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir ) 
        continue;
    end
     
    subdirpath = fullfile( maindir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath );
    
    for j = 1 : length( subsubdirpath )
        if( isequal( subsubdirpath( j ).name, '.' ) || ...
            isequal( subsubdirpath( j ).name, '..' ) || ...
            ~subsubdirpath( j ).isdir )
            continue;
        end
 
        subsubsubdirpath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, '*.jpg' );
        images = dir( subsubsubdirpath );   % 在这个子文件夹下找后缀为jpg的文件


        for k = 1 : length( images )
            imagepath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
            imgdata = imread( imagepath );   % 这里进行你的读取操作
            
            imgdata = rgb2gray( imgdata ); % color images, convert it to gray
        
            pix(:, :, k ) =  imgdata;
        end

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