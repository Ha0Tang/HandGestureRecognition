function descriptor=SurfDescriptor_GetDescriptor(ip, bUpright, bExtended, img, verbose)
% This function SurfDescriptor_GetDescriptor will ..
%
% [descriptor] = SurfDescriptor_GetDescriptor( ip,bUpright,bExtended,img )
%  
%  inputs,
%    ip : Interest Point (x,y,scale, orientation)
%    bUpright : If true not rotation invariant descriptor
%    bExtended :  If true make a 128 values descriptor
%    img : Integral image
%    verbose : If true show additional information
%  
%  outputs,
%    descriptor : Descriptor of interest point length 64 or 128 (extended)  
%  
% Function is written by D.Kroon University of Twente (July 2010)

% Get rounded InterestPoint data
X = round(ip.x);
Y = round(ip.y);
S = round(ip.scale);

if (bUpright)
    co = 1;
    si = 0;
else
    co = cos(ip.orientation);
    si = sin(ip.orientation);
end

% Basis coordinates of samples, if coordinate 0,0, and scale 1
[lb,kb]=ndgrid(-4:4,-4:4); lb=lb(:); kb=kb(:);

%Calculate descriptor for this interest point
[jl,il]=ndgrid(0:3,0:3); il=il(:)'; jl=jl(:)';

ix = (il*5-8);
jx = (jl*5-8);

% 2D matrices instead of double for-loops, il, jl
cx=length(lb); cy=length(ix);
lb=repmat(lb,[1 cy]); lb=lb(:);
kb=repmat(kb,[1 cy]); kb=kb(:);
ix=repmat(ix,[cx 1]); ix=ix(:);
jx=repmat(jx,[cx 1]); jx=jx(:);

% Coordinates of samples (not rotated)
l=lb+jx; k=kb+ix;

%Get coords of sample point on the rotated axis
sample_x = round(X + (-l * S * si + k * S * co)); 
sample_y = round(Y + (l * S * co + k * S * si));
                
%Get the gaussian weighted x and y responses
xs = round(X + (-(jx+1) * S * si + (ix+1) * S * co));
ys = round(Y + ((jx+1) * S * co + (ix+1) * S * si));

gauss_s1 = SurfDescriptor_Gaussian(xs - sample_x, ys - sample_y, 2.5 * S);
rx = IntegralImage_HaarX(sample_y, sample_x, 2 * S,img);
ry = IntegralImage_HaarY(sample_y, sample_x, 2 * S,img);
                
%Get the gaussian weighted x and y responses on the aligned axis
rrx = gauss_s1 .* (-rx * si + ry * co);  rrx=reshape(rrx,cx,cy);
rry = gauss_s1 .* ( rx * co + ry * si);  rry=reshape(rry,cx,cy);
        
% Get the gaussian scaling
cx = -0.5 + il + 1; cy = -0.5 + jl + 1;
gauss_s2 = SurfDescriptor_Gaussian(cx - 2, cy - 2, 1.5);

if (bExtended)
    % split x responses for different signs of y
    check=rry >= 0; rrx_p=rrx.*check;  rrx_n=rrx.*(~check);
    
    dx = sum(rrx_p); mdx = sum(abs(rrx_p),1);
    dx_yn = sum(rrx_n); mdx_yn = sum(abs(rrx_n),1);

    % split y responses for different signs of x
    check=(rrx >= 0); rry_p=rry.*check; rry_n=rry.*(~check);
    dy = sum(rry_p,1); 
    mdy = sum(abs(rry_p),1);
    dy_xn = sum(rry_n,1); 
    mdy_xn =  sum(abs(rry_n),1);
else
    dx = sum(rrx,1);
    dy = sum(rry,1);
    mdx = sum(abs(rrx),1);
    mdy = sum(abs(rry),1);
    dx_yn = 0; mdx_yn = 0; 
    dy_xn = 0; mdy_xn = 0;
end

if (bExtended)
    descriptor=[dx;dy;mdx;mdy;dx_yn;dy_xn;mdx_yn;mdy_xn].* repmat(gauss_s2,[8 1]);
else
    descriptor=[dx;dy;mdx;mdy].* repmat(gauss_s2,[4 1]);
end
  
len = sum((dx.^2 + dy.^2 + mdx.^2 + mdy.^2 + dx_yn + dy_xn + mdx_yn + mdy_xn) .* gauss_s2.^2);

%Convert to Unit Vector
descriptor= descriptor(:) / sqrt(len);
if(verbose)
    for i=1:size(rrx,2)
        p1=reshape(rrx(:,i),[9,9]);
        p2=reshape(rry(:,i),[9,9]);
        p=[p1;ones(1,9)*0.02;p2];
        if(i==1)
            pic=p;
        else
            pic=[pic ones(19,1)*0.02 p];
        end
    end
    imshow(pic,[]);
end

function an= SurfDescriptor_Gaussian(x, y, sig)
an = 1 / (2 * pi * sig^2) .* exp(-(x.^2 + y.^2) / (2 * sig^2));

