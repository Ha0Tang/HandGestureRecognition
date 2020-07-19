function im = im2col_general(varargin)
% 

NumInput = length(varargin);
InImg = varargin{1};
patchsize12 = varargin{2}; 

z = size(InImg,3);
im = cell(z,1);
if NumInput == 2
    for i = 1:z
        im{i} = im2colstep(InImg(:,:,i),patchsize12)';
    end
else
    for i = 1:z
        im{i} = im2colstep(InImg(:,:,i),patchsize12,varargin{3})';
    end 
end
im = [im{:}]';
    
    