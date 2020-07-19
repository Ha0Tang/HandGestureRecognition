% 将图像序列每帧用BoW表示，最后在拼接在一起
% clc; clear all; 
tic
addpath(genpath('FLANN'))
%% 产生字典 现在用的是 K-means 
% ANN index 参数
build_params.algorithm = 'autotuned';
build_params.target_precision = 0.98; % a high precision is desirable w.r.t quantization
build_params.build_weight = 0.00;
build_params.memory_weight = 0.00;
build_params.sample_fraction = 0.9;

% Cambridge 一共有9类，
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_split';
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_3entropy';
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_4entropy';
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_5entropy';
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_7entropy';
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_9entropy';
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_5entropy_cutoff';

% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_cutoff';

% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy';
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy';
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy';
% maindir =  'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_8entropy';

% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_cutoff_64';

% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_2';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_1';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_3';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_4';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_5';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_8';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_10';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_15';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_20';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_512';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_64';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_128';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_256';

% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy_128';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy_256';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy_512';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy_64';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy_32';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy_16';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy_8';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy_4';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy_2';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy_1';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy_1024';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy_2048';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_3entropy_4096';

% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy_1';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy_2';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy_4';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy_8';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy_16';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy_32';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy_64';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy_128';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy_256';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy_512';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy_1024';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy_2048';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_4entropy_4096';

% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_1';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_2';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_4';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_8';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_16';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_32';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_64';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_128';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_256';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_384';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_512';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_1024';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_2048';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_3072';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Northwestern_color_10_key_frames_max_5entropy_4096';


% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_3entropy_1';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_4entropy_4096';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_5entropy_1';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_5entropy_cutoff_64';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_6entropy_4096';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_7entropy_4096';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     K = 1;
%     K = 2;
%     K = 4;
%     K = 8;
%     K = 16;
%     K = 32;
%     K = 64;
%     K = 128;
%     K = 256;
%     K = 512;
%     K = 1024;
%     K = 2048;
%     K = 4096;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subdir =  dir( maindir );   % 先确定子文件夹
for i = 3 : length( subdir )
    surf_feature =[];
    BoW_surf = [];
    feature = [];
    matdata =[];
    index =[];
    parameters = [];
    Centroids =[];
    
    subdirpath = fullfile( maindir, subdir( i ).name);
    subsubdirpath = dir( subdirpath );   
    for j = 3 : length( subsubdirpath )
        matpath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name  )
        submatpath = dir( matpath );
            for s = 3 : length( submatpath )
                matmatpath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name , submatpath(s).name)
                matdata = load( matmatpath );   % 这里进行你的读取操作
                surf_feature =[surf_feature; matdata.feature];
            end
    end
    ndata = size(surf_feature, 1);
    surf_feature = surf_feature';
    % calculate rootSURF 将提取的SURF特征转成rootSURF特征
%     sum_val = sum(surf_feature);
%     for n = 1:128
%         surf_feature(n, :) = surf_feature(n, :)./sum_val;
%     end
%     surf_feature = sqrt(surf_feature);
   
    X = surf_feature; %  X的每一列对应一个特征点

    % 产生字典
    fprintf('build %d th vocabulary...\r\n', i-2);
%     [Centroids, Indexs]=kmeans(X,K);  % 这里可以换成AKM 这个kmeans在matlab15上运行出错
    [Centroids, Indexs]=vl_kmeans(X,K); 
    Centroids = single(Centroids);
    fprintf('build %d th vocabulary done!\r\n', i-2);
    
    % build ANN index
    fprintf('build %d th Ann index...\r\n', i-2);
    [index, parameters, speedup] = flann_build_index(Centroids, build_params);
    fprintf('build %d th Ann index done!\r\n', i-2);
    
    % 产生BoW向量
    fprintf('build %d th BoW vector...\r\n', i-2);
    for j = 3 : length( subsubdirpath )
        matpath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name  );
        submatpath = dir( matpath );
            for s = 3 : length( submatpath )
                matmatpath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name , submatpath(s).name)
                matdata = load( matmatpath );   % 这里进行你的读取操作
                feature_query = matdata.feature;
                feature_query = feature_query';
                % calculate rootSIFT
%                 feature_query = feature_query'; % 128 x n的形式
%                 sum_val = sum(feature_query);
%                 for m = 1:128
%                     feature_query(m, :) = feature_query(m, :)./sum_val;
%                 end
%                 feature_query = single(sqrt(feature_query));

                % perform ANN search
                kNN = 1; % number of visual words to be assigned to a feature
                % kNN = 10; % number of visual words to be assigned to a feature
                [visual_word, dist] = flann_search(index, single(feature_query), kNN, parameters); % visual_word is the index of quantized words
                BoWvec = hist( double(visual_word), 1:size(Centroids,2) );
                BoW_surf = [BoW_surf, BoWvec];
                % Plot the histogram of visual word occurrences
        %         figure; bar(BoWvec)
        %         title('Visual word occurrences')
        %         xlabel('Visual word index')
        %         ylabel('Frequency of occurrence')
            end
                feature = [feature; BoW_surf];
                BoW_surf =[];
                fprintf(' %d th \r\n', j-2);
    end
        savepath = fullfile(feaDir, subdir( i ).name);   
        if ~isdir(savepath),
            mkdir(savepath);
        end;
        save(savepath, 'feature');
        rmdir(savepath)
        feature = [];
        surf_feature = [];
    fprintf('build %d th BoW vector done!\r\n', i-2);
end
toc

