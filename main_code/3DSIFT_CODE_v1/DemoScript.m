% Short demo to calculate 3DSIFT descriptors
% Short demonstration showing how to call 3DSIFT
%
clc; clear all; tic 
maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_70\';
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\N\';
subdir =  dir( maindir );   % 先确定子文件夹
 
for k = 1 : length( subdir )
    if( isequal( subdir( k ).name, '.' ) || ...
        isequal( subdir( k ).name, '..' ) || ...
        ~subdir( k ).isdir )   % 如果不是目录跳过
        continue;
    end
     
    subdirpath = fullfile( maindir, subdir( k ).name, '*.avi' );
    videos = dir( subdirpath );   % 在这个子文件夹下找后缀为.avi的文件
     
    % 遍历每个视频
    for j = 1 : length( videos )
        videopath = fullfile( maindir, subdir( k ).name, videos( j ).name  )
        avif = VideoReader(videopath);
        pix = double(zeros(avif.Height,avif.Width,avif.NumberOfFrames));
        for i=1:avif.NumberOfFrames
            frame = read(avif,i);
            pix(:,:,i) = double(rgb2gray(frame));
            disp(i);
        end
        % 产生200个随机的点
        randPoint=200;
        videoSize=size(pix);
        x=videoSize(1);
        y=videoSize(2);
        t=videoSize(3);
        rand_x=randi(x,randPoint,1);
        rand_y=randi(y,randPoint,1);
        rand_t=randi(t,randPoint,1);
        subs =[rand_x, rand_y, rand_t];
        
        % Generate 200 descriptors at locations given by subs matrix
        for i=1:randPoint
            loc = subs(i,:);
            fprintf(1,'Calculating keypoint at location (%d, %d, %d)\n',loc);
            % Create a 3DSIFT descriptor at the given location
            [keys{j, i} reRun] = Create_Descriptor(pix,1,1,loc(1),loc(2),loc(3));
        end
    end
        savepath = fullfile( maindir, subdir( k ).name);
        save(savepath, 'keys');
        clear keys
end
toc

