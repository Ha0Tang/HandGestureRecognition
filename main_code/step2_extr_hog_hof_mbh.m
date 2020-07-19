clc; clear all; tic
addpath('HOG+HOF')

% HOG/HOF settings
blockSize = [6 6 6]; % block size is 6 by 6 pixels by 6 frames, but we will vary the number of frames
numBlocks = [3 3 2]; % 3 x3 spatial blocks and 2 temporal blocks
numOr = 8; % Quantization in 8 orientations
flowMethod = 'Horn-Schunck'; % For HOF only

hogDesc = cell(4, 1);
hogInfo = cell(4, 1);

hofDesc = cell(4, 1);
hofInfo = cell(4, 1);

MBHRowDesc = cell(4, 1);
MBHColDesc = cell(4, 1);
mbhInfo = cell(4, 1);

imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\01';
hog_feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\hog+hof_feature\Northwestern';
hof_feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\hog+hof_feature\Northwestern';
mbh_feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\hog+hof_feature\Northwestern';

subdir =  dir( imgDir );    
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )  
        continue;
    end
     
    subdirpath = fullfile( imgDir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath );
    
    for j = 1 : length( subsubdirpath )
        if( isequal( subsubdirpath( j ).name, '.' ) || ...
            isequal( subsubdirpath( j ).name, '..' ) || ...
            ~subsubdirpath( j ).isdir )  
            continue;
        end
 
        subsubsubdirpath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, '*.jpg' )
        images = dir( subsubsubdirpath );  

        for k = 1 : length( images ) 
            imagepath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
            imgdata = imread( imagepath );   
            
            imgdata = rgb2gray( imgdata ); % color images, convert it to gray
        
            VolData(:, :, k ) =  imgdata;
        end
        vid = im2double( VolData );
        
        % call HOG
        idx = 1;

        for frameSampleRate=1
            % Subsample framerate of video
            sampledVid = vid(:,:,1:frameSampleRate:end);  % 至少要12帧
            
            % Get correct number of frames per block
            blockSize(3) = 6 / frameSampleRate;
            
            % Get HOG descriptors
            [hogDesc{idx}, hogInfo{idx}] = Video2DenseHOGVolumes(sampledVid, blockSize, numBlocks, numOr);
            idx = idx + 1;
        end
        % call HOF
        idx = 1;

        for frameSampleRate=1
            % Subsample framerate of video
            sampledVid = vid(:,:,1:frameSampleRate:end); % 至少要13帧
            
            % Get correct number of frames per block
            blockSize(3) = 6 / frameSampleRate;
            
            % Get HOF descriptors
            [hofDesc{idx}, hofInfo{idx}] = Video2DenseHOFVolumes(sampledVid, blockSize, numBlocks, numOr, flowMethod);
            idx = idx + 1;
        end
        % call MBH
        idx = 1;

        for frameSampleRate=1
            % Subsample framerate of video
            sampledVid = vid(:,:,1:frameSampleRate:end); % 最少13帧

            % Get correct number of frames per block
            blockSize(3) = 6 / frameSampleRate;

            % Get MBH descriptors
            [MBHRowDesc{idx}, MBHColDesc{idx}, mbhInfo{idx}] = ...
                Video2DenseMBHVolumes(sampledVid, blockSize, numBlocks, numOr, flowMethod);
            idx = idx + 1;
        end
        
        clear vid
        % save hog feature
        hog_feature = [hogDesc{1,1}; hogDesc{2,1}; hogDesc{3,1}; hogDesc{4,1}];    % Each row is a data instance.
        hog_f_spath = fullfile(hog_feaDir, subdir( i ).name, subsubdirpath( j ).name);
               
        if ~isdir(hog_f_spath),
            mkdir(hog_f_spath);
        end;
        save(hog_f_spath, 'hog_feature');
        rmdir(hog_f_spath)
        
        % save hof feature
        hof_feature = [hofDesc{1,1}; hofDesc{2,1}; hofDesc{3,1}; hofDesc{4,1}];    % Each row is a data instance.
        hof_f_spath = fullfile(hof_feaDir, subdir( i ).name, subsubdirpath( j ).name);
               
        if ~isdir(hof_f_spath),
            mkdir(hof_f_spath);
        end;
        save(hof_f_spath, 'hof_feature');
        rmdir(hof_f_spath)
        
        % save mbh feature
        mbh_feature = [hofDesc{1,1}; hofDesc{2,1}; hofDesc{3,1}; hofDesc{4,1}];    % Each row is a data instance.
        mbh_f_spath = fullfile(mbh_feaDir, subdir( i ).name, subsubdirpath( j ).name);
               
        if ~isdir(mbh_f_spath),
            mkdir(mbh_f_spath);
        end;
        save(mbh_f_spath, 'mbh_feature');
        rmdir(mbh_f_spath)
    end;
end
toc
fprintf('\nDone!\n');
