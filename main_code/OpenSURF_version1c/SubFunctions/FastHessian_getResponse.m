function an=FastHessian_getResponse(a,row, column,b)% This function FastHessian_getResponse will ..
%
% [an] = FastHessian_getResponse( a,row,column,b )
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
if(nargin<4)    scale=1;else    scale=fix(a.width/b.width);endan=a.responses(fix(scale*row) * a.width + fix(scale*column)+1);