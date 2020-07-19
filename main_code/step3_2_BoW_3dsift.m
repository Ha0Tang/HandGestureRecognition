clc; clear all; tic
addpath(genpath('FLANN'))
NumofEachClasses = 105;
sift3DpointNUM = 200;  

build_params.algorithm = 'autotuned';
build_params.target_precision = 0.98; % a high precision is desirable w.r.t quantization
build_params.build_weight = 0.00;
build_params.memory_weight = 0.00;
build_params.sample_fraction = 0.9;

maindir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_original\';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_4\';

subdir =  dir( maindir );
% h = waitbar(0,'Please wait...');
num = length( subdir ) ;
for i = 3 : num 
    sift3d_feature =[];
    BoW_sift3d = [];
    matdata = [];
    index =[];
    parameters = [];
    Centroids =[];
    speedup = [];
    
    matpath = fullfile( maindir, subdir( i ).name);
    matdata = load( matpath );
    for k=1:NumofEachClasses
        for j=1:sift3DpointNUM
            sift3d_feature =[sift3d_feature; matdata.keys{k,j}.ivec];
        end
    end
    ndata = size(sift3d_feature, 1);
    sift3d_feature = sift3d_feature';
   
    X = double(sift3d_feature);
    fprintf('build %d th vocabulary...\r\n', i-2);

    [Centroids, Indexs]=vl_kmeans(X,K);
    Centroids = single(Centroids);
    fprintf('build %d th vocabulary done!\r\n', i-2);
    
    % build ANN index
    fprintf('build %d th Ann index...\r\n', i-2);
    [index, parameters, speedup] = flann_build_index(Centroids, build_params);
    fprintf('build %d th Ann index done!\r\n', i-2);
    
    fprintf('build %d th BoW vector...\r\n', i-2);
    for r=1:NumofEachClasses
        featureToBoW =[]; 
        BoWvec =[];
        for j=1:sift3DpointNUM
            featureToBoW(j,:) = matdata.keys{r,j}.ivec;
        end
        featureToBoW =featureToBoW';

        % perform ANN search
        kNN = 1; % number of visual words to be assigned to a feature
        
        [visual_word, dist] = flann_search(index, single(featureToBoW), kNN, parameters); % visual_word is the index of quantized words
        BoWvec = hist( double(visual_word), 1:size(Centroids,2) );
        BoW_sift3d = [BoW_sift3d; BoWvec];
            fprintf(' %d th \r\n', r);
        % Plot the histogram of visual word occurrences
        %         figure; bar(BoWvec)
        %         title('Visual word occurrences')
        %         xlabel('Visual word index')
        %         ylabel('Frequency of occurrence')
    end
        savepath = fullfile(feaDir, subdir( i ).name(1:2));   
        if ~isdir(savepath),
            mkdir(savepath);
        end;
        save(savepath, 'BoW_sift3d');
        rmdir(savepath)
        clear BoW_sift3d
        clear sift3d_feature
        clear featureToBoW 
        fprintf('build %d th BoW vector done!\r\n', i-2);
end
toc