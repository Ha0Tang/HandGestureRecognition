%% 两层文件夹下的所有图像的Surf特征提取 一幅图像保存为一个mat文件
% % Cambridge_color_9_keyframe 
% clc; clear all; tic
% % surf 参数
% Options.upright=true;
% Options.tresh=0.0001;
% 
% feature =[];
% addpath(genpath('OpenSURF_version1c')) 
% % imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_keyframe';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_split';
% % imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_3entropy';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy';
% % imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_4entropy';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy';
% imgDir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_5entropy';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy';
% 
% subdir =  dir( imgDir );   % 先确定子文件夹
% for i = 3: length( subdir )    
%     subdirpath = fullfile( imgDir, subdir( i ).name);   
%     subsubdirpath = dir( subdirpath ); 
%     for j = 3 : length( subsubdirpath )
%         subsubsubdirpath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name);
%         images = dir( subsubsubdirpath );   % 在这个子文件夹下找后缀为jpg的文件
% 
%         for k = 3 : length( images )
%             imagepath = fullfile( imgDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
%             % 提取SURF特征
%             iamge = imread(imagepath) ;
%             Ipts=OpenSurf(iamge,Options);
%             for q = 1:size(Ipts,2)
%                 feature = [feature; Ipts(q).descriptor'];
%             end     
%             savepath = fullfile(feaDir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name(1:11) );   %这个（1:10）很关键
%             if ~isdir(savepath),
%                 mkdir(savepath);
%             end;
%             save(savepath, 'feature');
%             rmdir(savepath)
%             feature =[];
%         end
%     end
% end
% toc

% This demo extracts features for the 'peppers.png' file for a number of
% times to show the computational performance of this software
%
% It also shows how to create colour descriptors
clc
disp('Copyright (c) Jasper Uijlings / University of Amsterdam')
disp('Contact information: jrr.uijlings@gmail.com')
disp(' ')
disp('This function extracts gives a demo of our fast/real-time extraction of')
disp('SIFT and SURF features. Scientists who produce results using our software')
disp('or a modified version thereof are requested to acknowledge this by ')
disp('citing the following article:')
disp(' ')
disp('     J.R.R. Uijlings, A.W.M. Smeulders, R.J.H. Scha')
disp('     Real-time Visual Concept Detection')
disp('     IEEE Transactions on Multimedia, 2010')
disp(' ')
disp('<press enter to continue>')

if exist('anigauss') ~= 3
    pause
    disp('Compiling: "Fast Anisotropic Gauss Filtering, IEEE Trans. Image Processing, 2003')
    disp('J.M. Geusebroek, A.W.M. Smeulders, and J. van de Weijer')
    disp('Available at: www.science.uva.nl/~mark')
    mex anigauss_mex.c anigauss.c -output anigauss
    disp('<press enter to continue>')
end

% Settings:
imName = 'peppers.png';
nrSift = 50;
nrSurf = 50;

% Read in image
im = im2double(imread(imName)); % Load standard Matlab image
imshow(im);
imGray = rgb2gray(im);


disp(' ')
disp('%%%%%%%%%%%%%%%%%%%% Computational Efficiency Tests %%%')
disp(' ')
disp('Extract 4x4-SIFT with subregions of 6 by 6 pixels with a ')
disp('Gaussian Derivative filter of sigma 1.')
fprintf('Extracting SIFT %d times: ', nrSift);
tic
for i=1:nrSift
    [featSift infoSift] = DenseSift(imGray, 6, 1, 4);
end
fprintf('%.0f ms per image\n\n', toc * 1000 / nrSift);
disp('<press enter to continue>')
pause

disp('Extract 4x4-SUFT with subregions of 3 by 3 pixels with')
disp('haar Filters of 4 by 4 pixels')
fprintf('Extracting SURF %d times: ', nrSurf);
tic
for i=1:nrSurf
    [featSurf infoSurf] = DenseSurf(imGray, 3, 2, 4);
end
fprintf('%.0f ms per image\n', toc * 1000 / nrSurf);
disp('<press enter to continue>')
pause
disp(' ')
disp(' ')
disp('%%%%% Other Colour spaces %%%%%')
disp(' ')
disp('It is also possible to use different Colour implementations:')
disp('Simply calculate the feature for multiple individual colour')
disp('channels and concatenate the results.')
clear featRgbSift
for i=1:size(im,3)
    [featRgbSift{i} infoRgbSift] = DenseSift(im(:,:,i), 6, 1, 4);
end
featRgbSift = cat(2, featRgbSift{:});

clear featRgbSurf
for i=1:size(im,3)
    [featRgbSurf{i} infoRgbSurf] = DenseSurf(im(:,:,i), 3, 2, 4);
end
featRgbSurf = cat(2, featRgbSurf{:});

disp(' ')
disp('Your workspace now contains SIFT features, SURF features, RGB-SIFT')
disp('features, and RGB-SURF features with corresponding info structs:')
whos feat*
