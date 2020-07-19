% [hogs, info] = Video2DenseHOGVolumes(video, blockSize, numBlocks, numOr)
%
% Get Densely Sampled Histogram of Oriented Gradients volume descriptors
% from a video. Final size of the volume per descriptor is 
% (blockSize .* numBlocks) pixels.
% - Oriented Gradients are calculated using HAAR features
% - Soft cell-borders within a single frame (linear interpolation in 
%   row and col directions)
% - Hard cell-borders in time direction
% - Sampling is as dense as subcells
%
% video:            N x M x F grayscale video
% blockSize:        1 x 3 vector with sub-block size in pixels ([pRow pCol pFrames]
% numBlocks:        1 x 3 vector with number of blocks [nRow nCol nZ]
% numOr (optional): Number of orientations for the histogram (default: 8)
%
% hogs:             Hog descriptors
% info:             Info structure containing:
%       row:        row coordinates of descriptors
%       col:        column coordinates
%       depth:      depth coordinates
%       descSize:   descriptor size in pixels (warning: incorrect when
%                   using subsampled frames in the videos
%
%           Jasper Uijlings - 2013
