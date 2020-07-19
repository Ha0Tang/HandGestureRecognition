%% Northwestern 10�� ��ԭʼ3D SIFT��������һ���任
% clc; clear all;
% % ԭʼ�����Ķ���original�ļ�����,��ԭʼ���������Ƶ�together�ļ�����
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_together\' ;
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_mean\' ;
% 
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy\' ;
% subdir = dir( maindir );   % ��ȷ�����ļ���
%  
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' ) || ...
%         isequal( subdir( i ).name, '..' ) )  
%         continue;
%     end
%      
%     matpath = fullfile( maindir, subdir( i ).name)
%     matdata = load( matpath );   % ���������Ķ�ȡ����
%     for j=1:105
%         for k=1:200
%             feature(j, (k-1)*640+1:(k-1)*640+640) = matdata.keys{j, k}.ivec;
%         end
%     end
%     savepath = fullfile( maindir, subdir( i ).name)
%     save(savepath, 'feature'); 
% end

%% ��Northwestern����Ƶ�����ݿ��Ͻ���ȡ3D SIFT����������BoW��ʾ
% clc; clear all; tic
% addpath(genpath('FLANN'))
% NumofEachClasses = 105;
% sift3DpointNUM = 200;  
% % �����ֵ� �����õ��� K-means 
% % ANN index ����
% build_params.algorithm = 'autotuned';
% build_params.target_precision = 0.98; % a high precision is desirable w.r.t quantization
% build_params.build_weight = 0.00;
% build_params.memory_weight = 0.00;
% build_params.sample_fraction = 0.9;
% 
% % Northwestern һ����10�࣬
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_8';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_64';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_72';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_80';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_96';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_100';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_104';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_106';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_108';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_110';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_112';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_128';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_256_vlkmeans';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_256_kmeans';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_512';
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %     K = 1024;
%     K = 512;
% %     K = 256;
% %     K = 128;
% %     K = 100;
% %     K = 104;
% %     K = 106;
% %     K = 108;
% %     K = 110;
% %     K = 112;
% %     K = 64;
% %     K = 96;
% %     K = 80;
% %     K = 72;
% %     K = 8;
% %     K = 1;
% %     K = 2;
% %     K = 3;
% %     K = 4;
% %     K = 5;
% %     K = 10;
% %     K = 20;
% %     K = 15;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subdir =  dir( maindir );   % ��ȷ�����ļ���
% % h = waitbar(0,'Please wait...');
% num = length( subdir ) ;
% for i = 3 : num 
%     sift3d_feature =[];
%     BoW_sift3d = [];
%     matdata = [];
%     index =[];
%     parameters = [];
%     Centroids =[];
%     speedup = [];
%     
%     matpath = fullfile( maindir, subdir( i ).name);
%     matdata = load( matpath );   % ���������Ķ�ȡ����
%     for k=1:NumofEachClasses
%         for j=1:sift3DpointNUM
%             sift3d_feature =[sift3d_feature; matdata.keys{k,j}.ivec];
%         end
%     end
%     ndata = size(sift3d_feature, 1);
%     sift3d_feature = sift3d_feature';
%     % calculate rootSURF ����ȡ��SURF����ת��rootSURF����
% %     sum_val = sum(surf_feature);
% %     for n = 1:128
% %         surf_feature(n, :) = surf_feature(n, :)./sum_val;
% %     end
% %     surf_feature = sqrt(surf_feature);
%    
%     X = double(sift3d_feature); %  X��ÿһ�ж�Ӧһ��������
%     % �����ֵ�
%     fprintf('build %d th vocabulary...\r\n', i-2);
%     [Centroids, Indexs]=kmeans(X,K);  % ������Ի���AKM ���kmeans��matlab15�����г���
% %     [Centroids, Indexs]=vl_kmeans(X,K);  % ������Ի���AKM ���kmeans��matlab15�����г���
%     Centroids = single(Centroids);
%     fprintf('build %d th vocabulary done!\r\n', i-2);
%     
%     % build ANN index
%     fprintf('build %d th Ann index...\r\n', i-2);
%     [index, parameters, speedup] = flann_build_index(Centroids, build_params);
%     fprintf('build %d th Ann index done!\r\n', i-2);
%     
%     % ����BoW����
%     fprintf('build %d th BoW vector...\r\n', i-2);
%     for r=1:NumofEachClasses
%         featureToBoW =[]; 
%         BoWvec =[];
%         for j=1:sift3DpointNUM
%             featureToBoW(j,:) = matdata.keys{r,j}.ivec;
%         end
%         featureToBoW =featureToBoW';
%         % calculate rootSIFT
%         % feature_query = feature_query'; % 128 x n����ʽ
%         % sum_val = sum(feature_query);
%         % for m = 1:128
%         %     feature_query(m, :) = feature_query(m, :)./sum_val;
%         % end
%         % feature_query = single(sqrt(feature_query));
% 
%         % perform ANN search
%         kNN = 1; % number of visual words to be assigned to a feature
%         % kNN = 10; % number of visual words to be assigned to a feature
%         
%         [visual_word, dist] = flann_search(index, single(featureToBoW), kNN, parameters); % visual_word is the index of quantized words
%         BoWvec = hist( double(visual_word), 1:size(Centroids,2) );
%         BoW_sift3d = [BoW_sift3d; BoWvec];
%             fprintf(' %d th \r\n', r);
%         % Plot the histogram of visual word occurrences
%         %         figure; bar(BoWvec)
%         %         title('Visual word occurrences')
%         %         xlabel('Visual word index')
%         %         ylabel('Frequency of occurrence')
%     end
%         savepath = fullfile(feaDir, subdir( i ).name(1:2));   
%         if ~isdir(savepath),
%             mkdir(savepath);
%         end;
%         save(savepath, 'BoW_sift3d');
%         rmdir(savepath)
%         clear BoW_sift3d
%         clear sift3d_feature
%         clear featureToBoW 
%         fprintf('build %d th BoW vector done!\r\n', i-2);
% %             waitbar((i-2)/num,h); % ��������ʾ
% end
% toc

%% ��Northwestern���ؼ�ֵ����ȡ�ؼ�֡�����ݿ��Ͻ���ȡ3D SIFT����������BoW��ʾ
clc; clear all; tic
addpath(genpath('FLANN'))
NumofEachClasses = 105;
sift3DpointNUM = 200;  
% �����ֵ� �����õ��� K-means 
% ANN index ����
build_params.algorithm = 'autotuned';
build_params.target_precision = 0.98; % a high precision is desirable w.r.t quantization
build_params.build_weight = 0.00;
build_params.memory_weight = 0.00;
build_params.sample_fraction = 0.9;

% Northwestern һ����10�࣬
maindir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_original\';

% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_1\';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_2\';
feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_4\';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_8\';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_16\';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_32\';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_64\';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_128\';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_256\';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_384\';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_512\';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_1024\';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_2048\';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_3072\';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_key_frames_max_5entropy_4096\';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     K = 4096;
%     K = 3072;
%     K = 2048;
%     K = 1024;
%     K = 512;
%     K = 384;
%     K = 256;
%     K = 128;
%     K = 100;
%     K = 104;
%     K = 106;
%     K = 108;
%     K = 110;
%     K = 112;
%     K = 64;
%     K = 32;
%     K = 16;
%     K = 96;
%     K = 80;
%     K = 72;
%     K = 8;
%     K = 1;
%     K = 2;
%     K = 3;
    K = 4;
%     K = 5;
%     K = 10;
%     K = 20;
%     K = 15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
subdir =  dir( maindir );   % ��ȷ�����ļ���
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
    matdata = load( matpath );   % ���������Ķ�ȡ����
    for k=1:NumofEachClasses
        for j=1:sift3DpointNUM
            sift3d_feature =[sift3d_feature; matdata.keys{k,j}.ivec];
        end
    end
    ndata = size(sift3d_feature, 1);
    sift3d_feature = sift3d_feature';
    % calculate rootSURF ����ȡ��SURF����ת��rootSURF����
%     sum_val = sum(surf_feature);
%     for n = 1:128
%         surf_feature(n, :) = surf_feature(n, :)./sum_val;
%     end
%     surf_feature = sqrt(surf_feature);
   
    X = double(sift3d_feature); %  X��ÿһ�ж�Ӧһ��������
    % �����ֵ�
    fprintf('build %d th vocabulary...\r\n', i-2);
%     [Centroids, Indexs]=kmeans(X,K);  % ������Ի���AKM ���kmeans��matlab15�����г���
    [Centroids, Indexs]=vl_kmeans(X,K);  % ������Ի���AKM ���kmeans��matlab15�����г���
    Centroids = single(Centroids);
    fprintf('build %d th vocabulary done!\r\n', i-2);
    
    % build ANN index
    fprintf('build %d th Ann index...\r\n', i-2);
    [index, parameters, speedup] = flann_build_index(Centroids, build_params);
    fprintf('build %d th Ann index done!\r\n', i-2);
    
    % ����BoW����
    fprintf('build %d th BoW vector...\r\n', i-2);
    for r=1:NumofEachClasses
        featureToBoW =[]; 
        BoWvec =[];
        for j=1:sift3DpointNUM
            featureToBoW(j,:) = matdata.keys{r,j}.ivec;
        end
        featureToBoW =featureToBoW';
        % calculate rootSIFT
        % feature_query = feature_query'; % 128 x n����ʽ
        % sum_val = sum(feature_query);
        % for m = 1:128
        %     feature_query(m, :) = feature_query(m, :)./sum_val;
        % end
        % feature_query = single(sqrt(feature_query));

        % perform ANN search
        kNN = 1; % number of visual words to be assigned to a feature
        % kNN = 10; % number of visual words to be assigned to a feature
        
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
%             waitbar((i-2)/num,h); % ��������ʾ
end
toc

%% ��Cambridge�����У����ݿ��Ͻ���ȡ3D SIFT����������BoW��ʾ
% clc; clear all; tic
% addpath(genpath('FLANN'))
% NumofEachClasses = 100;
% sift3DpointNUM = 200;  
% % �����ֵ� �����õ��� K-means 
% % ANN index ����
% build_params.algorithm = 'autotuned';
% build_params.target_precision = 0.98; % a high precision is desirable w.r.t quantization
% build_params.build_weight = 0.00;
% build_params.memory_weight = 0.00;
% build_params.sample_fraction = 0.9;
% 
% % Northwestern һ����10�࣬
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_8';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_64';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_72';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_80';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_96';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_100';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_104';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_106';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_108';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_110';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_112';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_128';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_256_vlkmeans';
% % feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_256_kmeans';
% feaDir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Northwestern_color_10_original_BoW_512';
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %     K = 1024;
%     K = 512;
% %     K = 256;
% %     K = 128;
% %     K = 100;
% %     K = 104;
% %     K = 106;
% %     K = 108;
% %     K = 110;
% %     K = 112;
% %     K = 64;
% %     K = 96;
% %     K = 80;
% %     K = 72;
% %     K = 8;
% %     K = 1;
% %     K = 2;
% %     K = 3;
% %     K = 4;
% %     K = 5;
% %     K = 10;
% %     K = 20;
% %     K = 15;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% subdir =  dir( maindir );   % ��ȷ�����ļ���
% % h = waitbar(0,'Please wait...');
% num = length( subdir ) ;
% for i = 3 : num 
%     sift3d_feature =[];
%     BoW_sift3d = [];
%     matdata = [];
%     index =[];
%     parameters = [];
%     Centroids =[];
%     speedup = [];
%     
%     matpath = fullfile( maindir, subdir( i ).name);
%     matdata = load( matpath );   % ���������Ķ�ȡ����
%     for k=1:NumofEachClasses
%         for j=1:sift3DpointNUM
%             sift3d_feature =[sift3d_feature; matdata.keys{k,j}.ivec];
%         end
%     end
%     ndata = size(sift3d_feature, 1);
%     sift3d_feature = sift3d_feature';
%     % calculate rootSURF ����ȡ��SURF����ת��rootSURF����
% %     sum_val = sum(surf_feature);
% %     for n = 1:128
% %         surf_feature(n, :) = surf_feature(n, :)./sum_val;
% %     end
% %     surf_feature = sqrt(surf_feature);
%    
%     X = double(sift3d_feature); %  X��ÿһ�ж�Ӧһ��������
%     % �����ֵ�
%     fprintf('build %d th vocabulary...\r\n', i-2);
%     [Centroids, Indexs]=kmeans(X,K);  % ������Ի���AKM ���kmeans��matlab15�����г���
% %     [Centroids, Indexs]=vl_kmeans(X,K);  % ������Ի���AKM ���kmeans��matlab15�����г���
%     Centroids = single(Centroids);
%     fprintf('build %d th vocabulary done!\r\n', i-2);
%     
%     % build ANN index
%     fprintf('build %d th Ann index...\r\n', i-2);
%     [index, parameters, speedup] = flann_build_index(Centroids, build_params);
%     fprintf('build %d th Ann index done!\r\n', i-2);
%     
%     % ����BoW����
%     fprintf('build %d th BoW vector...\r\n', i-2);
%     for r=1:NumofEachClasses
%         featureToBoW =[]; 
%         BoWvec =[];
%         for j=1:sift3DpointNUM
%             featureToBoW(j,:) = matdata.keys{r,j}.ivec;
%         end
%         featureToBoW =featureToBoW';
%         % calculate rootSIFT
%         % feature_query = feature_query'; % 128 x n����ʽ
%         % sum_val = sum(feature_query);
%         % for m = 1:128
%         %     feature_query(m, :) = feature_query(m, :)./sum_val;
%         % end
%         % feature_query = single(sqrt(feature_query));
% 
%         % perform ANN search
%         kNN = 1; % number of visual words to be assigned to a feature
%         % kNN = 10; % number of visual words to be assigned to a feature
%         
%         [visual_word, dist] = flann_search(index, single(featureToBoW), kNN, parameters); % visual_word is the index of quantized words
%         BoWvec = hist( double(visual_word), 1:size(Centroids,2) );
%         BoW_sift3d = [BoW_sift3d; BoWvec];
%             fprintf(' %d th \r\n', r);
%         % Plot the histogram of visual word occurrences
%         %         figure; bar(BoWvec)
%         %         title('Visual word occurrences')
%         %         xlabel('Visual word index')
%         %         ylabel('Frequency of occurrence')
%     end
%         savepath = fullfile(feaDir, subdir( i ).name(1:2));   
%         if ~isdir(savepath),
%             mkdir(savepath);
%         end;
%         save(savepath, 'BoW_sift3d');
%         rmdir(savepath)
%         clear BoW_sift3d
%         clear sift3d_feature
%         clear featureToBoW 
%         fprintf('build %d th BoW vector done!\r\n', i-2);
% %             waitbar((i-2)/num,h); % ��������ʾ
% end
% toc
