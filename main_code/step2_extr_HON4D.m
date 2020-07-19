%% Read depth sequence
clc,clear,close all;
maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\MSR_3D_depth_12\';
subdir =  dir( maindir );   % 先确定子文件夹

% HON4D parameters
DIM = 120; % number of 4D projectors
P = loadProjector('000.txt',DIM);
cell = [];
cell.numR = 3;
cell.numC = 3;
cell.numD = 1;
cell.width = 12;
cell.height = 12;
cell.depth = 4;
cell.DIM = DIM;
feature = [];
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )   % 如果不是目录跳过
        continue;
    end
     
    subdirpath = fullfile( maindir, subdir( i ).name);
    DepthSeqPath = dir( subdirpath );   
    for j = 3 : length( DepthSeqPath )
        filename_depth = fullfile( maindir, subdir( i ).name, DepthSeqPath( j ).name  )
        data = load(filename_depth);
        depth = data.depth_part;
        
        % compute derivatives of depth
        num_frames = size(depth,3);
        gx =zeros(size(depth,1),size(depth,2),size(depth,3)-1);
        gy =zeros(size(depth,1),size(depth,2),size(depth,3)-1);
        gz =zeros(size(depth,1),size(depth,2),size(depth,3)-1);
        for indFrame=1:num_frames-1
            im1 = medfilt2(depth(:,:,indFrame), [5 5]);
            im2 = medfilt2(depth(:,:,indFrame+1), [5 5]);
            [dx,dy,dz] = gradient(cat(3,im1,im2),1,1,1);

            gx(:,:,indFrame) = dx(:,:,1);
            gy(:,:,indFrame) = dy(:,:,1);
            gz(:,:,indFrame) = dz(:,:,1);
        end
        
        % Find HON4D for an example point at coordinates [center_x,center_y] at depth frame number f
        % 产生200个随机的点
        randPointNum=200;
        x=size(depth,1);
        y=size(depth,2);
        f=size(depth,3);
        
        center_x=randi(x,randPointNum,1);
        center_y=randi(y,randPointNum,1);
        frame=randi([3, f],randPointNum,1); %帧数至少从3开始
        center_z = -1; % not used
        subs =[center_x, center_y, frame];
        %% Compute HON4D 
        for k=1:randPointNum
            loc = subs(k,:);
            fprintf('Calculating the %d-th keypoint at location (%d, %d, %d)\n',k,loc); 
            honv4 = get_honv4_feature(loc(3),gx,gy,gz, loc(1), loc(2), center_z, cell, P);
            feature = [feature; honv4];
        end
        savepath = fullfile( maindir, subdir( i ).name, DepthSeqPath( j ).name  )
        save(savepath, 'feature');
        clear feature
    end
end






