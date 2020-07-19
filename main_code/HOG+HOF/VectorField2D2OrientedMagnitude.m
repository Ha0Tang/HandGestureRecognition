function orientedMagnitude = VectorField2D2OrientedMagnitude(numOrientations, V1, V2)
% orientedMagnitude = VectorField2D2OrientedMagnitude(numOrientations, V1, V2)
%
% Make oriented magnitude for a 2d vector field. Perform linear interpolation
% between between orientations
%
% numOrientations:      The number of orientations.
% V1:                   N x M matrix containing direction in X1 OR
%                       N x M matrix of complex number containing full
%                       vector field. In this case V2 is ignored
% V2:                   N x M matrix containing direction in X2
%
% orientedMagnitude:    N x M x numOrientations matrix of oriented magnitudes
%
%    Jasper Uijlings - 2013

% Deal with possibility of vector field being a single complex matrix.
% (this happens in the optical flow toolbox)
if nargin == 3
    theMagnitude = sqrt(V1 .* V1 + V2 .* V2);
    theAngle = atan2(V1, V2);
else
    theMagnitude = abs(V1);
    theAngle = angle(V1);
end

% Allocate memory
orientedMagnitude = zeros(size(V1, 1), size(V1, 2), numOrientations);

% Now get orientation bins
binReal = (theAngle) * (numOrientations / (2 * pi));
binLow = floor(binReal);
weightHigh = binReal - binLow;
weightLow = 1 - weightHigh;
binLow = mod(binLow, numOrientations) + 1;
binHigh = binLow + 1;
binHigh(binHigh == (numOrientations+1)) = 1;

% Now add the lower bin
[colI, rowI] = meshgrid(1:size(orientedMagnitude,2), 1:size(orientedMagnitude,1));
indLow = sub2ind(size(orientedMagnitude), rowI(:), colI(:), binLow(:));
orientedMagnitude(indLow) = orientedMagnitude(indLow) + ...
                    theMagnitude(:) .* weightLow(:);

% And the higher bin
indHigh = sub2ind(size(orientedMagnitude), rowI(:), colI(:), binHigh(:));
orientedMagnitude(indHigh) = orientedMagnitude(indHigh) + ...
                    theMagnitude(:) .* weightHigh(:);
