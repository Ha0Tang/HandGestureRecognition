function rl=FastHessian_buildResponseLayer(rl,FastHessianData)
% This function FastHessian_buildResponseLayer will ..
%
% [rl] = FastHessian_buildResponseLayer( rl,FastHessianData )
%  
%  inputs,
%    rl : 
%    FastHessianData : 
%  
%  outputs,
%    rl : 
%  
% Function is written by D.Kroon University of Twente ()

step = fix( rl.step);                      % step size for this filter
b = fix((rl.filter - 1) / 2 + 1);         % border for this filter
l = fix(rl.filter / 3);                   % lobe for this filter (filter size / 3)
w = fix(rl.filter);                       % filter size

inverse_area = 1 / double(w * w);          % normalisation factor
img=FastHessianData.img;

[ac,ar]=ndgrid(0:rl.width-1,0:rl.height-1);
ar=ar(:); ac=ac(:);

% get the image coordinates
r = int32(ar * step);
c = int32(ac * step);

% Compute response components
Dxx =   IntegralImage_BoxIntegral(r - l + 1, c - b, 2 * l - 1, w,img) - IntegralImage_BoxIntegral(r - l + 1, c - fix(l / 2), 2 * l - 1, l, img) * 3;
Dyy =   IntegralImage_BoxIntegral(r - b, c - l + 1, w, 2 * l - 1,img) - IntegralImage_BoxIntegral(r - fix(l / 2), c - l + 1, l, 2 * l - 1,img) * 3;
Dxy = + IntegralImage_BoxIntegral(r - l, c + 1, l, l,img) + IntegralImage_BoxIntegral(r + 1, c - l, l, l,img) ...
      - IntegralImage_BoxIntegral(r - l, c - l, l, l,img) - IntegralImage_BoxIntegral(r + 1, c + 1, l, l,img);

% Normalise the filter responses with respect to their size
Dxx = Dxx*inverse_area;
Dyy = Dyy*inverse_area;
Dxy = Dxy*inverse_area;

% Get the determinant of hessian response & laplacian sign
rl.responses = (Dxx .* Dyy - 0.81 * Dxy .* Dxy);
rl.laplacian = (Dxx + Dyy) >= 0;
