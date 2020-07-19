% info = GetDenseInfoStructure3D(numSubregions, regionSize, offset)
%
% Gets the info structure for Dense Features. Calculates row,col,frame
% coordinates
%
% numSubregions: 1 x 3 vector denoting the number of subregions in 
%                [row, col, depth] direction
% regionSize:    1 x 3 vector with size of the descriptor
% offset:        1 x 3 vector with the offset where first descriptor starts
%
% info:         info structure used for a.o. making feature spatial
%   row:        row coordinate per feature
%   col:        col coordinate per feature
%   depth:      depth coordinate per feature
%
%       Jasper Uijlings - 2013
