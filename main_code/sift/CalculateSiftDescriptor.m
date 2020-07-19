function [database, lenStat] = CalculateSiftDescriptor(rt_img_dir, rt_data_dir, gridSpacing, patchSize, maxImSize, nrml_threshold)
%==========================================================================
% usage: calculate the sift descriptors given the image directory
%
% inputs
% rt_img_dir    -image database root path
% rt_data_dir   -feature database root path
% gridSpacing   -spacing for sampling dense descriptors
% patchSize     -patch size for extracting sift feature
% maxImSize     -maximum size of the input image
% nrml_threshold    -low contrast normalization threshold
%
% outputs
% database      -directory for the calculated sift features
%
% Lazebnik's SIFT code is used.
%
% written by Jianchao Yang
% Mar. 2009, IFP, UIUC
%==========================================================================

disp('Extracting SIFT features...');
subfolders = dir(rt_img_dir);

siftLens = [];

database = [];

database.imnum = 0; % total image number of the database
database.cname = {}; % name of each class
database.label = []; % label of each class
database.path = {}; % contain the pathes for each image of each class
database.nclass = 0;

for ii = 1:length(subfolders),
    subname = subfolders(ii).name;
    
    if ~strcmp(subname, '.') & ~strcmp(subname, '..'),
        database.nclass = database.nclass + 1;
        
        database.cname{database.nclass} = subname;
        
%         frames = dir(fullfile(rt_img_dir, subname, '*.png'));
        frames = dir(fullfile(rt_img_dir, subname, '*.jpg'));
        
        c_num = length(frames);           
        database.imnum = database.imnum + c_num;
        database.label = [database.label; ones(c_num, 1)*database.nclass];
        
        siftpath = fullfile(rt_data_dir, subname);        
        if ~isdir(siftpath),
            mkdir(siftpath);
        end;
        
        for jj = 1:c_num,
            imgpath = fullfile(rt_img_dir, subname, frames(jj).name);
            
            I = imread(imgpath);
            if ndims(I) == 3,
                I = im2double(rgb2gray(I));
            else
                I = im2double(I);
            end;
            
            [im_h, im_w] = size(I);
            
            if max(im_h, im_w) > maxImSize,
                I = imresize(I, maxImSize/max(im_h, im_w), 'bicubic');
                [im_h, im_w] = size(I);
            end;
            
            % make grid sampling SIFT descriptors
            remX = mod(im_w-patchSize,gridSpacing);
            offsetX = floor(remX/2)+1;
            remY = mod(im_h-patchSize,gridSpacing);
            offsetY = floor(remY/2)+1;
    
            [gridX,gridY] = meshgrid(offsetX:gridSpacing:im_w-patchSize+1, offsetY:gridSpacing:im_h-patchSize+1);

            fprintf('Processing %s: wid %d, hgt %d, grid size: %d x %d, %d patches\n', ...
                     frames(jj).name, im_w, im_h, size(gridX, 2), size(gridX, 1), numel(gridX));

            % find SIFT descriptors
            siftArr = sp_find_sift_grid(I, gridX, gridY, patchSize, 0.8);
            [siftArr, siftlen] = sp_normalize_sift(siftArr, nrml_threshold);
            
            siftLens = [siftLens; siftlen];
            
            feaSet.feaArr = siftArr';
            feaSet.x = gridX(:) + patchSize/2 - 0.5;
            feaSet.y = gridY(:) + patchSize/2 - 0.5;
            feaSet.width = im_w;
            feaSet.height = im_h;
            
            [pdir, fname] = fileparts(frames(jj).name);                        
            fpath = fullfile(rt_data_dir, subname, [fname, '.mat']);
            
            save(fpath, 'feaSet');
            database.path = [database.path, fpath];
        end;    
    end;
end;
    
lenStat = hist(siftLens, 100);
disp('Extracting SIFT features done! ');
