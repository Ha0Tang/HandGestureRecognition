clc; clear all; tic
addpath('HOG+HOF')

% Setup a global variable which contains the path of video files
global DATAopts
DATAopts.videoPath = '%s';

% HOG/HOF settings
blockSize = [6 6 6]; % block size is 6 by 6 pixels by 6 frames, but we will vary the number of frames
numBlocks = [3 3 2]; % 3 x3 spatial blocks and 2 temporal blocks
numOr = 8; % Quantization in 8 orientations
flowMethod = 'Horn-Schunck'; % For HOF only

hogDesc = cell(4, 1);
hogInfo = cell(4, 1);

hofDesc = cell(4, 1);
hofInfo = cell(4, 1);
idx = 1;

% 1 Northwestern, 熵极值法提取关键5帧?
imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_5entropy';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\hog+hof_feature\Northwestern_color_10_key_frames_max_5entropy';

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
        for frameSampleRate=[1 2 3 6]
            % Subsample framerate of video
            sampledVid = vid(:,:,1:frameSampleRate:end);  % 至少要12帧
            
            % Get correct number of frames per block
            blockSize(3) = 6 / frameSampleRate;
            
            % Get HOG descriptors
            [hogDesc{idx}, hogInfo{idx}] = Video2DenseHOGVolumes(sampledVid, blockSize, numBlocks, numOr);
            idx = idx + 1;
        end

        for frameSampleRate=[1 2 3 6]
            % Subsample framerate of video
            sampledVid = vid(:,:,1:frameSampleRate:end); % 至少要13帧
            
            % Get correct number of frames per block
            blockSize(3) = 6 / frameSampleRate;
            
            % Get HOG descriptors
            [hofDesc{idx}, hofInfo{idx}] = Video2DenseHOFVolumes(sampledVid, blockSize, numBlocks, numOr, flowMethod);
            idx = idx + 1;
        end

        clear VolData
        
        feature = Histogram';    % Each row is a data instance.
        fpath = fullfile(feaDir, subdir( i ).name, subsubdirpath( j ).name);
               
        if ~isdir(fpath),
            mkdir(fpath);
        end;
        save(fpath, 'feature');
        rmdir(fpath)
    end;
end
toc
fprintf('\nDone!\n');
