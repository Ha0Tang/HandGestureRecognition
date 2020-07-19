function D=FastHessian_BuildDerivative(r,c,t,m,b)% This function FastHessian_BuildDerivative will ..
%
% [D] = FastHessian_BuildDerivative( r,c,t,m,b )
%  
%  inputs,
%    r : 
%    c : 
%    t : 
%    m : 
%    b : 
%  
%  outputs,
%    D : 
%  
% Function is written by D.Kroon University of Twente ()
dx = (FastHessian_getResponse(m,r, c + 1, t) - FastHessian_getResponse(m,r, c - 1, t)) / 2;dy = (FastHessian_getResponse(m,r + 1, c, t) - FastHessian_getResponse(m,r - 1, c, t)) / 2;ds = (FastHessian_getResponse(t,r, c) - FastHessian_getResponse(b,r, c, t)) / 2;D = [dx;dy;ds];