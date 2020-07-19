clc; clear all; tic
addpath('LBP-TOP')
%% LBP-TOP
% parameter set

% 1. "FxRadius", "FyRadius" and "TInterval" are the radii parameter along X, Y and T axis; They can be 1, 2, 3 and 4. "1" and "3" are recommended.
%  Pay attention to "TInterval". "TInterval * 2 + 1" should be smaller than the length of the input sequence "Length". 
% For example, if one sequence includes seven frames, and you set TInterval
% to three, only the pixels in the frame 4 would be considered as central
% pixel and computed to get the LBP-TOP feature.
FxRadius = 1; 
FyRadius = 1;
TInterval = 1;

% 2. "TimeLength" and "BoderLength" are the parameters for bodering parts in time and space which would not
% be computed for features. Usually they are same to TInterval and the
% bigger one of "FxRadius" and "FyRadius";
TimeLength = 2;
BorderLength = 1;

% 3. "bBilinearInterpolation" : if use bilinear interpolation for computing a
% neighbor point in a circle: 1 (yes), 0 (not)
bBilinearInterpolation = 0;  % 0: not / 1: bilinear interpolation
%% 59 is only for neighboring points with 8. If won't compute uniform
%% patterns, please set it to 0, then basic LBP will be computed
Bincount = 59; %59 / 0
NeighborPoints = [8 8 8]; % XY, XT, and YT planes, respectively
if Bincount == 0
    Code = 0;
    nDim = 2 ^ (NeighborPoints(1));  %dimensionality of basic LBP
else
    % uniform patterns for neighboring points with 8
    U8File = importdata('UniformLBP8.txt');
    BinNum = U8File(1, 1);
    nDim = U8File(1, 2); %dimensionality of uniform patterns
    Code = U8File(2 : end, :);
    clear U8File;
end

imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_5entropy';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_5entropy';

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
            
            imgdata = rgb2gray( imgdata );
        
            VolData(:, :, k ) =  imgdata;
        end

        Histogram = LBPTOP(VolData, FxRadius, FyRadius, TInterval, NeighborPoints, TimeLength, BorderLength, bBilinearInterpolation, Bincount, Code);
        clear VolData
        plane1=Histogram(1,:);
        plane2=Histogram(2,:);
        plane3=Histogram(3,:);

        LBP_TOP_Feature = [plane1 plane2 plane3];
        fpath = fullfile(feaDir, subdir( i ).name, subsubdirpath( j ).name);
               
        if ~isdir(fpath),
            mkdir(fpath);
        end;
        save(fpath, 'LBP_TOP_Feature');
        rmdir(fpath)
    end;
end
toc

