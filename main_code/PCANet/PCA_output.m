function [OutImg OutImgIdx] = PCA_output(InImg, InImgIdx, PatchSize, NumFilters, V)
% Computing PCA filter outputs
% ======== INPUT ============
% InImg         Input images (cell structure); each cell can be either a matrix (Gray) or a 3D tensor (RGB)   
% InImgIdx      Image index for InImg (column vector)
% PatchSize     Patch size (or filter size); the patch is set to be sqaure
% NumFilters    Number of filters at the stage right before the output layer 
% V             PCA filter banks (cell structure); V{i} for filter bank in the ith stage  
% ======== OUTPUT ===========
% OutImg           filter output (cell structure)
% OutImgIdx        Image index for OutImg (column vector)
% OutImgIND        Indices of input patches that generate "OutImg"
% ===========================
addpath('./Utils')

ImgZ = length(InImg);
mag = (PatchSize-1)/2;
OutImg = cell(NumFilters*ImgZ,1); 
cnt = 0;
for i = 1:ImgZ
    [ImgX, ImgY, NumChls] = size(InImg{i});
    img = zeros(ImgX+PatchSize-1,ImgY+PatchSize-1, NumChls);
    img((mag+1):end-mag,(mag+1):end-mag,:) = InImg{i};     
    im = im2col_mean_removal(img,[PatchSize PatchSize]); % collect all the patches of the ith image in a matrix, and perform patch mean removal
    for j = 1:NumFilters
        cnt = cnt + 1;
        OutImg{cnt} = reshape(V(:,j)'*im,ImgX,ImgY);  % convolution output
    end
    InImg{i} = [];
end
OutImgIdx = kron(InImgIdx,ones(NumFilters,1)); 





