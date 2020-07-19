% [hofs, info] = Video2DenseHOFVolumes(video, blockSize, numBlocks, numOr, flowMethod
%
% Get Densely Sampled Histogram of Oriented Optical Flow volume descriptors
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
% hofs:             Hof descriptors
% info:             Info structure containing e.g. coordinates
%       row:        row coordinates of descriptors
%       col:        column coordinates
%       depth:      depth coordinates
%       descSize:   descriptor size in pixels (warning: incorrect when
%                   using subsampled frames in the videos
%
%           Jasper Uijlings - 2013
