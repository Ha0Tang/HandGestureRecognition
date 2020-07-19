%% Computing the gist descriptor
% Load image
img = imread('demo2.jpg');
imshow(img);

% GIST Parameters:
clear param
param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale (from HF to LF)
param.numberBlocks = 4;
param.fc_prefilt = 4;

% Computing gist:
[gist, param] = LMgist(img, '', param);

%% Visualization
% Visualization
figure
subplot(121)
imshow(img)
title('Input image')
subplot(122)
showGist(gist, param)
title('Descriptor')

%% Image similarities
% % Load images
% img1 = imread('demo1.jpg');
% img2 = imread('demo2.jpg');
% 
% % GIST Parameters:
% clear param
% param.imageSize = [256 256]; % it works also with non-square images (use the most common aspect ratio in your set)
% param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale
% param.numberBlocks = 4;
% param.fc_prefilt = 4;
% 
% % Computing gist:
% gist1 = LMgist(img1, '', param);
% gist2 = LMgist(img2, '', param);
% 
% % Distance between the two images:
% D = sum((gist1-gist2).^2)

%% Image collections
% % GIST Parameters:
% clear param
% param.imageSize = [256 256]; % set a normalized image size
% param.orientationsPerScale = [8 8 8 8]; % number of orientations per scale (from HF to LF)
% param.numberBlocks = 4;
% param.fc_prefilt = 4;
% 
% % Pre-allocate gist:
% Nfeatures = sum(param.orientationsPerScale)*param.numberBlocks^2;
% gist = zeros([Nimages Nfeatures]); 
% 
% % Load first image and compute gist:
% img = imread(file{1});
% [gist(1, :), param] = LMgist(img, '', param); % first call
% % Loop:
% for i = 2:Nimages
%    img = imread(file{i});
%    gist(i, :) = LMgist(img, '', param); % the next calls will be faster
% end