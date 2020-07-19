function an=FastHessian_getLaplacian(a,row, column,b)% This function FastHessian_getLaplacian will ..
%
% [an] = FastHessian_getLaplacian( a,row,column,b )
%  
%  inputs,
%    a : 
%    row : 
%    column : 
%    b : 
%  
%  outputs,
%    an : 
%  
% Function is written by D.Kroon University of Twente ()
if(nargin<4)    scale=1;else    scale=fix(a.width/b.width);endan=a.laplacian(fix(scale*row) * a.width + fix(scale*column)+1);