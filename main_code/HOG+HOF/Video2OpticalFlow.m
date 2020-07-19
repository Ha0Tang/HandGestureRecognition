function optFlowVid = Video2OpticalFlow(video, method)
% function optFlowVid = Video2OpticalFlow(video, method)
%
% Calculates optical flow from video for all frames differences
%
% video:        N x M x F double matrix containing grey-scale video
% method:       String denoting method. Possible values:
%               {'Horn-Schunck' (default), 'Lucas-Kanade'}
%
% optFlowVid:   N x M x (F-1) complex matrix with optical flow
%
% Note: Upgrade to at least Matlab 2013b for good computational efficiency
%
%           Jasper Uijlings - 2013


% Persistent variables for faster execution
persistent opticalFlowClass theMethod previousFrameSize;

if nargin == 1
    method = 'Horn-Schunck';
end

if strcmp(method, 'Horn-Schunck') || strcmp(method, 'Lucas-Kanade')

    currFrameSize = [size(video,1) size(video,2)];

    % Initialize class if does not yet exist or if the frame sizes are
    % different
    if isempty(opticalFlowClass) || ~strcmp(theMethod, method) || ...
          ~isequal(currFrameSize, previousFrameSize)  
        % Initialize optical flow class
        opticalFlowClass = vision.OpticalFlow('OutputValue', ...
                    'Horizontal and vertical components in complex form', 'Method', method);
        theMethod = method;

        % Process first frame
        step(opticalFlowClass, video(:,:,1));
    else
        % Optical flow class does exist.
        step(opticalFlowClass, video(:,:,1));
    end

    % Store size of previous video
    previousFrameSize = [size(video,1) size(video,2)];            


    % Allocate memory for optical flow
    optFlowVid = zeros(size(video,1), size(video,2), size(video,3)-1);

    % Now process optical flow for all frames
    for i=2:size(video,3)
        optFlowVid(:,:,i-1) = step(opticalFlowClass, video(:,:,i));
    end

else
    if strcmp(method, 'Farneback')
        optFlowVid = zeros(size(video,1), size(video,2), size(video,3)-1);
        
        for i=1:size(video,3)-1
            currOptFlow = cv.calcOpticalFlowFarneback(video(:,:,i),video(:,:,i+1));
            optFlowVid(:,:,i) = complex(currOptFlow(:,:,1), currOptFlow(:,:,2));
        end        
    end
end
