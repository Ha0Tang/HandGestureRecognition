% function ogIm = Image2OrientedGradientsHaar(im, numOr)
%
% Converts image into gray image. Then creates a n x m x 8 array where for
% each of 8 orientations (starting with y, and going clockwise), a
% magnitude is given. In contrast to Image2OrientedGradients,
% edge responses are calculated using haar features (-1 0 1) instead of a
% gaussian window. Furthermore, for a single pixel the magnitude is divided
% over only 2 orientation bins.
%
% im:               N x M The image
% numOr(optional):  Number of orientations (8 is default)
%
% ogIm:             N x M x numOr orientation responses
%
% Jasper Uijlings, 2013
