function [mbhRow, mbhCol, info] = Video2DenseMBHVolumes(video, blockSize, numBlocks, numOr, flowMethod)
% [hofs, info] = Video2DenseMBHVolumes(video, blockSize, numBlocks, numOr, flowMethod
%
% Get Densely Sampled Motion Boundary Histogram (MBH) descriptors
% from a video. Final size of the volume per descriptor is 
% (blockSize .* numBlocks) pixels.
% - Optical Flow is calculated using MATLABs CV toolbox
% - Soft cell-borders within a single frame (linear interpolation in 
%   row and col directions)
% - Hard cell-borders in time direction
% - Sampling is as dense as subcells
%
% video:            N x M x F grayscale video
% blockSize:        1 x 3 vector with sub-block size in pixels ([pRow pCol pFrames]
% numBlocks:        1 x 3 vector with number of blocks [nRow nCol nZ]
% numOr (optional): Number of orientations for the histogram (default: 8)
% flowMethod(optional): Method of optical opticalFlow: {'Horn-Schunck' (default), 'Lucas-Kanade'}
%
% mbhRow:           MBH descriptors in Row direction (Y)
% mbhCol:           MBH descriptors in Col direction (X)
% info:             Info structure containing e.g. coordinates
%
%           Jasper Uijlings - 2013
%         Ionut Cosmin Duta - 2014

if nargin < 4
    numOr = 8; % Default: 8 orientations
end

if nargin < 5
    flowMethod = 'Horn-Schunck'; % Horn-Schunk optical opticalFlow
end

% Calculate optical flow from the video
opticalFlow = Video2OpticalFlow(video, flowMethod);

% Motion boundary histograms can be calculated by considering each
% direction (row, col) of the flow volume as a video and simply
% calculating Histograms of Oriented Gradients.
flowRow = real(opticalFlow); % Y direction
flowCol = imag(opticalFlow); % X direction

% Extract local MBHs for each flow channel
mbhRow         = Video2DenseHOGVolumes(flowRow, blockSize, numBlocks, numOr);
[mbhCol, info] = Video2DenseHOGVolumes(flowCol, blockSize, numBlocks, numOr);

