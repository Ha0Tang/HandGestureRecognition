function responseMap=FastHessian_buildResponseMap(FastHessianData)

% Calculate responses for the first 4 FastHessianData.octaves:
% Oct1: 9,  15, 21, 27
% Oct2: 15, 27, 39, 51
% Oct3: 27, 51, 75, 99
% Oct4: 51, 99, 147,195
% Oct5: 99, 195,291,387

% Deallocate memory and clear any existing response layers
responseMap=[]; j=0;


% Get image attributes
w = (size(FastHessianData.img,2) / FastHessianData.init_sample);
h = (size(FastHessianData.img,1)/ FastHessianData.init_sample);
s = (FastHessianData.init_sample);

% Calculate approximated determinant of hessian values
if (FastHessianData.octaves >= 1)
    j=j+1; responseMap{j}=FastHessian_ResponseLayer(w,   h,   s,   9);
    j=j+1; responseMap{j}=FastHessian_ResponseLayer(w, h, s, 15);
    j=j+1; responseMap{j}=FastHessian_ResponseLayer(w, h, s, 21);
    j=j+1; responseMap{j}=FastHessian_ResponseLayer(w, h, s, 27);
end

if (FastHessianData.octaves >= 2)
    j=j+1; responseMap{j}=FastHessian_ResponseLayer(w / 2, h / 2, s * 2, 39);
    j=j+1; responseMap{j}=FastHessian_ResponseLayer(w / 2, h / 2, s * 2, 51);
end

if (FastHessianData.octaves >= 3)
    j=j+1; responseMap{j}=FastHessian_ResponseLayer(w / 4, h / 4, s * 4, 75);
    j=j+1; responseMap{j}=FastHessian_ResponseLayer(w / 4, h / 4, s * 4, 99);
end

if (FastHessianData.octaves >= 4)
    j=j+1; responseMap{j}=FastHessian_ResponseLayer(w / 8, h / 8, s * 8, 147);
    j=j+1; responseMap{j}=FastHessian_ResponseLayer(w / 8, h / 8, s * 8, 195);
end

if (FastHessianData.octaves >= 5)
    j=j+1; responseMap{j}=FastHessian_ResponseLayer(w / 16, h / 16, s * 16, 291);
    j=j+1; responseMap{j}=FastHessian_ResponseLayer(w / 16, h / 16, s * 16, 387);
end

% Extract responses from the image
for i=1:length(responseMap);
    responseMap{i}=FastHessian_buildResponseLayer(responseMap{i},FastHessianData);
end


