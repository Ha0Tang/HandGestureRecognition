% m = DiagMatrix(a, b)
%
% Creates a zero matrix with ones on the diagonal, where the diagonal goes
% from the top-left to bottom-right corner . If a equals b, then this
% function does the same as the Matlab build-in function 'eye'.
%
% Additionally, do a linear interpolation. This function can be used to 
% sum values over N x N regions within a matrix.
%
% NOTE: a / b OR b / a should result in an integer!
%
% a:        Number of rows
% b:        Number of columns
%
% m:        a x b matrix with ones on the diagonal and zeros elsewhere.
%
%       Jasper Uijlings - 2009