clc; clear all; tic
addpath(genpath('FLANN'))

build_params.algorithm = 'autotuned';
build_params.target_precision = 0.98; % a high precision is desirable w.r.t quantization
build_params.build_weight = 0.00;
build_params.memory_weight = 0.00;
build_params.sample_fraction = 0.9;

maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_together';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_256';
subdir =  dir( maindir );
sift_feature =[];
BoW_rootSIFT = [];
for i = 3 : length( subdir )     
    subdirpath = fullfile( maindir, subdir( i ).name, '*.mat' );
    
    matpath = dir( subdirpath );   
    for j = 1 : length( matpath )
        mat = fullfile( maindir, subdir( i ).name, matpath( j ).name  )
        matdata = load( mat );
        sift_feature =[sift_feature; matdata.feature];
    end
    ndata = size(sift_feature, 1);
    sift_feature = sift_feature';
    sum_val = sum(sift_feature);
    for n = 1:128
        sift_feature(n, :) = sift_feature(n, :)./sum_val;
    end
    sift_feature = sqrt(sift_feature);
   
    X = sift_feature;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     K = 1024;
%     K = 512;
    K = 256;
%     K = 128;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    fprintf('build vocabulary...\r\n');
    [Centroids, Indexs]=kmeans(X,K);  % 这里可以换成AKM 这个kmeans在matlab15上运行出错
    Centroids = single(Centroids);
    fprintf('build vocabulary done!\r\n');
    
    % build ANN index
    fprintf('build Ann index...\r\n');
    [index, parameters, speedup] = flann_build_index(Centroids, build_params);
    fprintf('build Ann index done!\r\n');
    
    fprintf('build BoW vector...\r\n');
    for j = 1 : length( matpath )
        mat = fullfile( maindir, subdir( i ).name, matpath( j ).name  )
        matdata = load( mat );  
        feature = matdata.feature;
        % calculate rootSIFT
        feature = feature'; % 128 x n的形式
        sum_val = sum(feature);
        for m = 1:128
            feature(m, :) = feature(m, :)./sum_val;
        end
        feature = single(sqrt(feature));

        % perform ANN search
        kNN = 1; % number of visual words to be assigned to a feature
        % kNN = 10; % number of visual words to be assigned to a feature
        [visual_word, dist] = flann_search(index, feature, kNN, parameters); % visual_word is the index of quantized words
        BoWvec = hist( double(visual_word), 1:size(Centroids,2) );
        BoW_rootSIFT = [BoW_rootSIFT; BoWvec];
        % Plot the histogram of visual word occurrences
%         figure; bar(BoWvec)
%         title('Visual word occurrences')
%         xlabel('Visual word index')
%         ylabel('Frequency of occurrence')
    end
        savepath = fullfile(feaDir, subdir( i ).name);   
        if ~isdir(savepath),
            mkdir(savepath);
        end;
        save(savepath, 'BoW_rootSIFT');
        rmdir(savepath)
        BoW_rootSIFT = [];
        sift_feature = [];
    fprintf('build BoW vector done!\r\n');
end
toc
