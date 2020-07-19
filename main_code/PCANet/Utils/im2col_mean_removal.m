function im = im2col_mean_removal(varargin)
% 

NumInput = length(varargin);
InImg = varargin{1};
patchsize12 = varargin{2}; 

z = size(InImg,3);
im = cell(z,1);
if NumInput == 2
    for i = 1:z
        iim = im2colstep(InImg(:,:,i),patchsize12);
        im{i} = bsxfun(@minus, iim, mean(iim))'; 
%         iim = bsxfun(@minus, iim, mean(iim)); 
%         im{i} = bsxfun(@minus, iim, mean(iim,2))';
    end
else
    for i = 1:z
        iim = im2colstep(InImg(:,:,i),patchsize12,varargin{3});
        im{i} = bsxfun(@minus, iim, mean(iim))'; 
%         iim = bsxfun(@minus, iim, mean(iim)); 
%         im{i} = bsxfun(@minus, iim, mean(iim,2))';
    end 
end
im = [im{:}]';
    
    