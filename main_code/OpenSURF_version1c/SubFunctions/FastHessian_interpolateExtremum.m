function [ipts, np]=FastHessian_interpolateExtremum(r, c,  t,  m,  b,  ipts, np)
% This function FastHessian_interpolateExtremum will ..
%
% [ipts,np] = FastHessian_interpolateExtremum( r,c,t,m,b,ipts,np )
%  
%  inputs,
%    r : 
%    c : 
%    t : 
%    m : 
%    b : 
%    ipts : 
%    np : 
%  
%  outputs,
%    ipts : 
%    np : 
%  
% Function is written by D.Kroon University of Twente (July 2010)
D = FastHessian_BuildDerivative(r, c, t, m, b);
H = FastHessian_BuildHessian(r, c, t, m, b);

%get the offsets from the interpolation
Of = - H\D;
O=[ Of(1, 1), Of(2, 1), Of(3, 1) ];

%get the step distance between filters
filterStep = fix((m.filter - b.filter));

%If point is sufficiently close to the actual extremum
if (abs(O(1)) < 0.5 && abs(O(2)) < 0.5 && abs(O(3)) < 0.5)
    np=np+1;
    ipts(np).x = double(((c + O(1))) * t.step);
    ipts(np).y = double(((r + O(2))) * t.step);
    ipts(np).scale = double(((2/15) * (m.filter + O(3) * filterStep)));
    ipts(np).laplacian = fix(FastHessian_getLaplacian(m,r,c,t));
end
  
function D=FastHessian_BuildDerivative(r,c,t,m,b)
dx = (FastHessian_getResponse(m,r, c + 1, t) - FastHessian_getResponse(m,r, c - 1, t)) / 2;
dy = (FastHessian_getResponse(m,r + 1, c, t) - FastHessian_getResponse(m,r - 1, c, t)) / 2;
ds = (FastHessian_getResponse(t,r, c) - FastHessian_getResponse(b,r, c, t)) / 2;
D = [dx;dy;ds];

function H=FastHessian_BuildHessian(r, c, t, m, b)
v = FastHessian_getResponse(m, r, c, t);
dxx = FastHessian_getResponse(m,r, c + 1, t) + FastHessian_getResponse(m,r, c - 1, t) - 2 * v;
dyy = FastHessian_getResponse(m,r + 1, c, t) + FastHessian_getResponse(m,r - 1, c, t) - 2 * v;
dss = FastHessian_getResponse(t,r, c) + FastHessian_getResponse(b,r, c, t) - 2 * v;
dxy = (FastHessian_getResponse(m,r + 1, c + 1, t) - FastHessian_getResponse(m,r + 1, c - 1, t) - FastHessian_getResponse(m,r - 1, c + 1, t) + FastHessian_getResponse(m,r - 1, c - 1, t)) / 4;
dxs = (FastHessian_getResponse(t,r, c + 1) - FastHessian_getResponse(t,r, c - 1) - FastHessian_getResponse(b,r, c + 1, t) + FastHessian_getResponse(b,r, c - 1, t)) / 4;
dys = (FastHessian_getResponse(t,r + 1, c) - FastHessian_getResponse(t,r - 1, c) - FastHessian_getResponse(b,r + 1, c, t) + FastHessian_getResponse(b,r - 1, c, t)) / 4;

H = zeros(3,3);
H(1, 1) = dxx;
H(1, 2) = dxy;
H(1, 3) = dxs;
H(2, 1) = dxy;
H(2, 2) = dyy;
H(2, 3) = dys;
H(3, 1) = dxs;
H(3, 2) = dys;
H(3, 3) = dss;
