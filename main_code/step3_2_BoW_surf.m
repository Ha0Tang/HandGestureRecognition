% clc; clear all; 
tic
addpath(genpath('FLANN'))

build_params.algorithm = 'autotuned';
build_params.target_precision = 0.98; % a high precision is desirable w.r.t quantization
build_params.build_weight = 0.00;
build_params.memory_weight = 0.00;
build_params.sample_fraction = 0.9;

subdir =  dir( maindir ); 
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
                matdata = load( matmatpath );
                surf_feature =[surf_feature; matdata.feature];
            end
    end
    ndata = size(surf_feature, 1);
    surf_feature = surf_feature';

   
    X = surf_feature; %  X的每一列对应一个特征点

    fprintf('build %d th vocabulary...\r\n', i-2);
    [Centroids, Indexs]=vl_kmeans(X,K); 
    Centroids = single(Centroids);
    fprintf('build %d th vocabulary done!\r\n', i-2);
    
    % build ANN index
    fprintf('build %d th Ann index...\r\n', i-2);
    [index, parameters, speedup] = flann_build_index(Centroids, build_params);
    fprintf('build %d th Ann index done!\r\n', i-2);
    
    fprintf('build %d th BoW vector...\r\n', i-2);
    for j = 3 : length( subsubdirpath )
        matpath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name  );
        submatpath = dir( matpath );
            for s = 3 : length( submatpath )
                matmatpath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name , submatpath(s).name)
                matdata = load( matmatpath );   % 这里进行你的读取操作
                feature_query = matdata.feature;
                feature_query = feature_query';

                % perform ANN search
                kNN = 1; % number of visual words to be assigned to a feature
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

