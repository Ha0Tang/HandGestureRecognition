%%  方法0：一种特征的together
% clc; clear all;
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9\' ;
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_keyframe\' ;
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9\' ;
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_keyframe\' ;
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Cambridge_color_9_keyframe\' ;
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\hsv_feature\Cambridge_color_9_keyframe\' ;
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe\' ;
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe_riu2\' ;
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe_ri\' ;
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\clbp_feature\Cambridge_color_9_keyframe_u2\' ;
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_5entropy\' ;
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Cambridge_color_9_5entropy\' ;
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_5entropy';
% 
% 
% subdir = dir( maindir );   % 先确定子文件夹
% feature = [];
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' ) || ...
%         isequal( subdir( i ).name, '..' ) || ...
%         ~subdir( i ).isdir )   % 如果不是目录跳过
%         continue;
%     end
%      
%     subdirpath = fullfile( maindir, subdir( i ).name, '*.mat' );
%     mat = dir( subdirpath );   % 在这个子文件夹下找后缀为mat的文件
%      
%     % 遍历每个mat文件
%     
%     for j = 1 : length( mat )
%         matpath = fullfile( maindir, subdir( i ).name, mat( j ).name  )
%         matdata = load( matpath );   % 这里进行你的读取操作
% %         feature = [feature; matdata.clbpfeature]; % 一行是一个样本
% %         feature = [feature; matdata.lbpfeature]; % 一行是一个样本
% %         feature = [feature; matdata.Gistfeature]; % 一行是一个样本
% %         feature = [feature; matdata.LBP_TOP_Feature]; % 一行是一个样本
%         feature = [feature; matdata.VLBP_Feature]; % 一行是一个样本
%     end
%     savepath = fullfile( maindir, subdir( i ).name)
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  together 对原始3D SIFT特征作进一步变换
% clc; clear all;
% % 原始特征的都在original文件夹中,将原始的特征复制到together文件夹下
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Cambridge_color_9_together\' ;
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Cambridge_color_9_5entropy\' ;
% 
% 
% subdir = dir( maindir );   % 先确定子文件夹
%  
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' ) || ...
%         isequal( subdir( i ).name, '..' ) )  
%         continue;
%     end
%      
%     matpath = fullfile( maindir, subdir( i ).name)
%     matdata = load( matpath );   % 这里进行你的读取操作
%     for j=1:100
%         for k=1:200
%             feature(j, (k-1)*640+1:(k-1)*640+640) = matdata.keys{j, k}.ivec;
%         end
%     end
%     savepath = fullfile( maindir, subdir( i ).name)
%     save(savepath, 'feature'); 
% end


%%  方法一： 两个特征的融合 lbp-top + 每帧gist
% clc; clear all;
% % save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp_top+gist';
% % main_lbp_top_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_keyframe\together\' ;
% % main_gist_dir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Cambridge_color_9_keyframe\together\' ;
% % save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\cam_lbp_top+gist';
% % main_lbp_top_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_5entropy\together\' ;
% % main_gist_dir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Cambridge_color_9_5entropy\together\' ;
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\nor_lbp_top+gist';
% main_lbp_top_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Northwestern_color_10_key_frames_max_5entropy\together\' ;
% main_gist_dir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Northwestern_color_10_key_frames_max_5entropy\together\' ;
% 
% sub_lbp_top_dir = dir( main_lbp_top_dir );   % 先确定子文件夹
% sub_gist_dir = dir( main_gist_dir );   % 先确定子文件夹
% feature = [];
% for i = 3 : length( sub_lbp_top_dir )
%     subsub_lbp_top_dir = fullfile( main_lbp_top_dir, sub_lbp_top_dir( i ).name);
%     mat_lbp_top_data = load( subsub_lbp_top_dir );   % 这里进行你的读取操作
%     
%     subsub_gist_dir = fullfile( main_gist_dir, sub_gist_dir( i ).name);
%     mat_gist_data = load( subsub_gist_dir );   % 这里进行你的读取操作
%     feature = [mat_lbp_top_data.feature, mat_gist_data.feature]; % 一行是一个样本
%     
%     savepath = fullfile( save_dir, sub_lbp_top_dir( i ).name)
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  方法二： 两个特征的融合 vlbp + 每帧gist
% clc; clear all;
% % save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+gist';
% % main_vlbp_dir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_keyframe\together\' ;
% % main_gist_dir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Cambridge_color_9_keyframe\together\' ;
% % save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\cam_vlbp+gist';
% % main_vlbp_dir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_5entropy\together\' ;
% % main_gist_dir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Cambridge_color_9_5entropy\together\' ;
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\nor_vlbp+gist';
% main_vlbp_dir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Northwestern_color_10_key_frames_max_5entropy\together\' ;
% main_gist_dir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Northwestern_color_10_key_frames_max_5entropy\together\' ;
% 
% sub_vlbp_dir = dir( main_vlbp_dir );   % 先确定子文件夹
% sub_gist_dir = dir( main_gist_dir );   % 先确定子文件夹
% feature = [];
% for i = 3 : length( sub_vlbp_dir )
%     subsub_vlbp_dir = fullfile( main_vlbp_dir, sub_vlbp_dir( i ).name);
%     mat_vlbp_data = load( subsub_vlbp_dir );   % 这里进行你的读取操作
%     
%     subsub_gist_dir = fullfile( main_gist_dir, sub_gist_dir( i ).name);
%     mat_gist_data = load( subsub_gist_dir );   % 这里进行你的读取操作
%     feature = [mat_vlbp_data.feature, mat_gist_data.feature]; % 一行是一个样本
%     
%     savepath = fullfile( save_dir, sub_vlbp_dir( i ).name)
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  方法三： 两个特征的融合 vlbp + 整个序列BoW rootSIFT
% clc; clear all;
% % save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+BoW-rootSIFT-1024';
% % save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+BoW-rootSIFT-512';
% % save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+BoW-rootSIFT-256';
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+BoW-rootSIFT-128';
% main_vlbp_dir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_keyframe\together\' ;
% % main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_1024\' ;
% % main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_512\' ;
% % main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_256\' ;
% main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_128\' ;
% sub_vlbp_dir = dir( main_vlbp_dir );   % 先确定子文件夹
% sub_rootSIFT_dir = dir( main_rootSIFT_dir );   % 先确定子文件夹
% feature = [];
% for i = 3 : length( sub_vlbp_dir )
%     subsub_vlbp_dir = fullfile( main_vlbp_dir, sub_vlbp_dir( i ).name);
%     mat_vlbp_data = load( subsub_vlbp_dir );   % 这里进行你的读取操作
%     
%     subsub_gist_dir = fullfile( main_rootSIFT_dir, sub_rootSIFT_dir( i ).name);
%     mat_rootSIFT_data = load( subsub_gist_dir );   % 这里进行你的读取操作
%     feature = [mat_vlbp_data.feature, mat_rootSIFT_data.BoW_rootSIFT]; % 一行是一个样本
%     
%     savepath = fullfile( save_dir, sub_vlbp_dir( i ).name)
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  方法四： 两个特征的融合 lbp-top + 整个序列BoW rootSIFT
% clc; clear all;
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+BoW-rootSIFT';
% main_lbp_top_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_keyframe\together\' ;
% main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW\' ;
% sub_lbp_top_dir = dir( main_lbp_top_dir );   % 先确定子文件夹
% sub_rootSIFT_dir = dir( main_rootSIFT_dir );   % 先确定子文件夹
% feature = [];
% for i = 3 : length( sub_lbp_top_dir )
%     subsub_lbp_top_dir = fullfile( main_lbp_top_dir, sub_lbp_top_dir( i ).name);
%     mat_lbp_top_data = load( subsub_lbp_top_dir );   % 这里进行你的读取操作
%     
%     subsub_gist_dir = fullfile( main_rootSIFT_dir, sub_rootSIFT_dir( i ).name);
%     mat_rootSIFT_data = load( subsub_gist_dir );   % 这里进行你的读取操作
%     feature = [mat_lbp_top_data.feature, mat_rootSIFT_data.BoW_rootSIFT]; % 一行是一个样本
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     savepath = fullfile( save_dir, sub_lbp_top_dir( i ).name)
% 
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  方法5： 两个特征的融合 lbp-top + 每帧BoW rootSIFT表示
% clc; clear all;
% % save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+split_BoW-rootSIFT_512';
% % save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+split_BoW-rootSIFT_256';
% % save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+split_BoW-rootSIFT_128';
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+split_BoW-rootSIFT_64';
% main_lbp_top_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_keyframe\together\' ;
% % main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_512\' ;
% % main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_256\' ;
% % main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_128\' ;
% main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_64\' ;
% sub_lbp_top_dir = dir( main_lbp_top_dir );   % 先确定子文件夹
% sub_rootSIFT_dir = dir( main_rootSIFT_dir );   % 先确定子文件夹
% feature = [];
% for i = 3 : length( sub_lbp_top_dir )
%     subsub_lbp_top_dir = fullfile( main_lbp_top_dir, sub_lbp_top_dir( i ).name);
%     mat_lbp_top_data = load( subsub_lbp_top_dir );   % 这里进行你的读取操作
%     
%     subsub_gist_dir = fullfile( main_rootSIFT_dir, sub_rootSIFT_dir( i ).name);
%     mat_rootSIFT_data = load( subsub_gist_dir );   % 这里进行你的读取操作
%     feature = [mat_lbp_top_data.feature, mat_rootSIFT_data.feature]; % 一行是一个样本
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     savepath = fullfile( save_dir, sub_lbp_top_dir( i ).name)
% 
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  方法6： 两个特征的融合 vlbp + 每帧BoW rootSIFT表示
% clc; clear all;
% % save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+split_BoW-rootSIFT_64';
% % save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+split_BoW-rootSIFT_128';
% % save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+split_BoW-rootSIFT_256';
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+split_BoW-rootSIFT_512';
% main_vlbp_dir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_keyframe\together\' ;
% % main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_64\' ;
% % main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_128\' ;
% % main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_256\' ;
% main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_512\' ;
% sub_vlbp_dir = dir( main_vlbp_dir );   % 先确定子文件夹
% sub_rootSIFT_dir = dir( main_rootSIFT_dir );   % 先确定子文件夹
% feature = [];
% for i = 3 : length( sub_vlbp_dir )
%     subsub_vlbp_dir = fullfile( main_vlbp_dir, sub_vlbp_dir( i ).name);
%     mat_vlbp_data = load( subsub_vlbp_dir );   % 这里进行你的读取操作
%     
%     subsub_rootSIFT_dir = fullfile( main_rootSIFT_dir, sub_rootSIFT_dir( i ).name);
%     mat_rootSIFT_data = load( subsub_rootSIFT_dir );   % 这里进行你的读取操作
%     feature = [mat_vlbp_data.feature, mat_rootSIFT_data.feature]; % 一行是一个样本
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     savepath = fullfile( save_dir, sub_vlbp_dir( i ).name)
% 
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  方法7： 关键帧每帧 HSV + LBP
% clc; clear all;
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp+hsv';
% main_lbp_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe\together\' ;;
% main_hsv_dir = 'F:\Myprojects\matlabProjects\featureExtraction\hsv_feature\Cambridge_color_9_keyframe\together\' ;
% sub_lbp_dir = dir( main_lbp_dir );   % 先确定子文件夹
% sub_hsv_dir = dir( main_hsv_dir );   % 先确定子文件夹
% feature = [];
% for i = 3 : length( sub_lbp_dir )
%     subsub_lbp_dir = fullfile( main_lbp_dir, sub_lbp_dir( i ).name);
%     mat_lbp_data = load( subsub_lbp_dir );   % 这里进行你的读取操作
%     
%     subsub_hsv_dir = fullfile( main_hsv_dir, sub_hsv_dir( i ).name);
%     mat_hsv_data = load( subsub_hsv_dir );   % 这里进行你的读取操作
%     feature = [mat_lbp_data.feature, mat_hsv_data.feature]; % 一行是一个样本
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     savepath = fullfile( save_dir, sub_lbp_dir( i ).name)
% 
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  方法8： 关键帧每帧 vlbp + LBP
% clc; clear all;
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+lbp';
% main_lbp_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe\together\' ;;
% main_vlbp_dir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_keyframe\together\' ;
% sub_lbp_dir = dir( main_lbp_dir );   % 先确定子文件夹
% sub_vlbp_dir = dir( main_vlbp_dir );   % 先确定子文件夹
% feature = [];
% for i = 3 : length( sub_lbp_dir )
%     subsub_lbp_dir = fullfile( main_lbp_dir, sub_lbp_dir( i ).name);
%     mat_lbp_data = load( subsub_lbp_dir );   % 这里进行你的读取操作
%     
%     subsub_vlbp_dir = fullfile( main_vlbp_dir, sub_vlbp_dir( i ).name);
%     mat_vlbp_data = load( subsub_vlbp_dir );   % 这里进行你的读取操作
%     feature = [mat_lbp_data.feature, mat_vlbp_data.feature]; % 一行是一个样本
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     savepath = fullfile( save_dir, sub_lbp_dir( i ).name)
% 
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  方法9： 关键帧每帧 lbp_top + LBP
% clc; clear all;
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp_top+lbp';
% main_lbp_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe\together\' ;;
% main_lbp_top_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_keyframe\together\' ;
% sub_lbp_dir = dir( main_lbp_dir );   % 先确定子文件夹
% sub_lbp_top_dir = dir( main_lbp_top_dir );   % 先确定子文件夹
% feature = [];
% for i = 3 : length( sub_lbp_dir )
%     subsub_lbp_dir = fullfile( main_lbp_dir, sub_lbp_dir( i ).name);
%     mat_lbp_data = load( subsub_lbp_dir );   % 这里进行你的读取操作
%     
%     subsub_lbp_top_dir = fullfile( main_lbp_top_dir, sub_lbp_top_dir( i ).name);
%     mat_lbp_top_data = load( subsub_lbp_top_dir );   % 这里进行你的读取操作
%     feature = [mat_lbp_data.feature, mat_lbp_top_data.feature]; % 一行是一个样本
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     savepath = fullfile( save_dir, sub_lbp_dir( i ).name)
% 
%     save(savepath, 'feature'); 
%     feature = [];
% end


%%  方法10： 两个特征的融合 SIFT 3D + 每帧gist
% clc; clear all;
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\cam_sift3d+gist';
% main_sift3d_dir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Cambridge_color_9_5entropy\' ;
% main_gist_dir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Cambridge_color_9_5entropy\together\' ;
% 
% sub_vlbp_dir = dir( main_sift3d_dir );   % 先确定子文件夹
% sub_gist_dir = dir( main_gist_dir );   % 先确定子文件夹
% feature = [];
% for i = 3 : length( sub_vlbp_dir )
%     subsub_vlbp_dir = fullfile( main_sift3d_dir, sub_vlbp_dir( i ).name);
%     mat_vlbp_data = load( subsub_vlbp_dir );   % 这里进行你的读取操作
%     
%     subsub_gist_dir = fullfile( main_gist_dir, sub_gist_dir( i ).name);
%     mat_gist_data = load( subsub_gist_dir );   % 这里进行你的读取操作
%     feature = [mat_vlbp_data.feature, mat_gist_data.feature]; % 一行是一个样本
%     
%     savepath = fullfile( save_dir, sub_vlbp_dir( i ).name)
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% 先执行上面的程序，在执行下面的程序
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% train and test data
clc; clear all;
% % 1 对于Cambridge数据库，每个完整和的序列提取lbp-top特征
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9\together\' ;
% % 2 对于Cambridge数据库，每个完整和的序列，首先得到关键帧，再对关键帧提取lbp-top特征
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_keyframe\together\' ;
% % 3 对于Cambridge数据库，每个完整和的序列提取vlbp特征
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9\together\' ;
% % 4 对于Cambridge数据库，每个完整和的序列，首先得到关键帧，再对关键帧提取vlbp特征
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_keyframe\together\' ;
% % 5 关键5帧提取lbp-top，同时每帧提取gist特征
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp_top+gist\' ;
% % 6 关键5帧提取vlbp，同时每帧提取gist特征
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+gist\' ;
 % 7 只用关键5帧，提取rootSIFT特征，经过每类自己的聚类，产生每类自己的字典，每类字典大小1024
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_1024\' ;
 % 8 只用关键5帧，对于这5帧提取VLBP特征；对于5帧中的每一帧提起rootSIFT特征，经过每类自己的聚类，产生每类自己的字典，每类字典大小1024
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+BoW-rootSIFT\' ;
 % 9 只用关键5帧，对于这5帧提取LBP-TOP特征；对于5帧中的每一帧提起rootSIFT特征，经过每类自己的聚类，产生每类自己的字典，每类字典大小1024
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+BoW-rootSIFT\' ;
 % 10 只用关键5帧，对于5帧中的每一帧提取rootSIFT特征，经过每类自己的聚类，产生每类自己的字典，每类字典大小512
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_512\' ;
 % 11 只用关键5帧，对于5帧中的每一帧提取rootSIFT特征，经过每类自己的聚类，产生每类自己的字典，每类字典大小128
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_128\' ;
 % 12 只用关键5帧，对于5帧中的每一帧提取rootSIFT特征，经过每类自己的聚类，产生每类自己的字典，每类字典大小256
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_256\' ;
 % 13 只用关键5帧，对于5帧提取vlbp特征；对于5帧中的每一帧提取rootSIFT特征，经过每类自己的聚类，产生每类自己的字典，每类字典大小512
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+BoW-rootSIFT-512\' ;
 % 14 只用关键5帧，对于5帧提取vlbp特征；对于5帧中的每一帧提取rootSIFT特征，经过每类自己的聚类，产生每类自己的字典，每类字典大小256
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+BoW-rootSIFT-256\' ;
 % 15 只用关键5帧，对于5帧提取vlbp特征；对于5帧中的每一帧提取rootSIFT特征，经过每类自己的聚类，产生每类自己的字典，每类字典大小128
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+BoW-rootSIFT-128\' ;
 % 16 只用关键5帧，对于5帧中的每一帧提取rootSIFT特征，经过每类自己的聚类，产生每类自己的字典，每类字典大小128,
 % 每张图片用BoW向量表示，然后再拼接在一起，一共128*5=640维
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_128\' ;
 % 17 与16相比 只是维度变成了64*5=320维
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_64\' ;
 % 18 与16相比 只是维度变成了256*5=1280维
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_256\' ;
 % 19 与16相比 只是维度变成了512*5=2560维
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_512\' ;
 % 20 关键帧lbp-top + 每帧提取BoW rootSIFT特征再拼接 每类字典512
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+split_BoW-rootSIFT_512\' ;
 % 21 关键帧lbp-top + 每帧提取BoW rootSIFT特征再拼接 每类字典256
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+split_BoW-rootSIFT_256\' ;
 % 22 关键帧lbp-top + 每帧提取BoW rootSIFT特征再拼接 每类字典128
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+split_BoW-rootSIFT_128\' ;
 % 22 关键帧lbp-top + 每帧提取BoW rootSIFT特征再拼接 每类字典64
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+split_BoW-rootSIFT_64\' ;
 % 23 关键帧vlbp + 每帧提取BoW rootSIFT特征再拼接 每类字典64
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+split_BoW-rootSIFT_64\' ;
 % 24 关键帧vlbp + 每帧提取BoW rootSIFT特征再拼接 每类字典128
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+split_BoW-rootSIFT_128\' ;
 % 25 关键帧vlbp + 每帧提取BoW rootSIFT特征再拼接 每类字典256
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+split_BoW-rootSIFT_256\' ;
 % 26 关键帧vlbp + 每帧提取BoW rootSIFT特征再拼接 每类字典512
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+split_BoW-rootSIFT_512\' ;
 % 27 关键帧每帧提取1000维HSV特征
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\hsv_feature\Cambridge_color_9_keyframe\together\' ;
 % 28 关键帧每帧提取512维Gist特征
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Cambridge_color_9_keyframe\together\' ;
 % 29 关键帧每帧提取59维lbp（u2）特征
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe\together\' ;
 % 30 关键帧每帧提取lbp（u2）+hsv特征
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp+hsv\' ;
 % 31 关键帧每帧提取lbp(riu2模式)特征
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe_riu2\together\' ;
 % 32 关键帧每帧提取lbp(ri模式)特征
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe_ri\together\' ;
 % 33 关键帧每帧提取vlbp+lbp(u2模式)特征
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+lbp\' ;
 % 34 关键帧每帧提取lbp-top+lbp(u2模式)特征
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp_top+lbp\' ;
 % 35 关键帧每帧提取clbp(u2模式)特征
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\clbp_feature\Cambridge_color_9_keyframe_u2\together\' ;
 % 36 关键帧每帧提取surf特征, 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为512
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_512\' ;
 % 37 关键帧每帧提取surf特征, 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为64
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_64\' ;
 % 38 关键帧每帧提取surf特征, 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为8
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_8\' ;
 % 39 关键帧每帧提取surf特征, 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为2
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_2\' ;
 % 40 关键帧每帧提取surf特征, 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为1
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_1\' ;
 % 41 关键帧每帧提取surf特征, 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为3
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_3\' ;
 % 42 关键帧每帧提取surf特征, 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为4
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_4\' ;
 % 43 关键帧每帧提取surf特征, 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为5
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_5\' ;
 % 44 关键帧每帧提取surf特征, 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为10
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_10\' ;
 % 45 关键帧每帧提取surf特征, 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为20
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_20\' ;
 % 46 关键帧每帧提取surf特征, 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为15
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_15\' ;
 % 46 关键帧每帧提取surf特征, 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为128
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_128\' ;
 % 47 关键帧每帧提取surf特征, 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为256
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_256\' ;
 % 48 关键帧每帧提取hog特征 在自己电脑上跑会内存溢出
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\hog_feature\Cambridge_color_9_keyframe_2_2\' ; 
 % 49 提取3D SIFT特征 每个序列随机选择200个点
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Cambridge_color_9_together\' ; 
 % 50 对极值法提取的关键5帧，提取lbp-top特征
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_5entropy\together\' ; 
 % 51 熵极值法关键3帧每帧提取surf特征,
 % 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为1,2，4,8,16,32,64,128,256,512,1024,2048,4096
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_3entropy_4096\' ;
 % 52 熵极值法关键4帧每帧提取surf特征,
 % 然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为1,2，4,8,16,32,64,128,256,512,1024,2048,4096
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_4entropy_4096\' ;
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_5entropy_1\' ;
 % 52 熵极值法关键5帧每帧提取surf特征,
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_5entropy_cutoff_64\' ; 
 % 53 熵极值法关键5帧每帧提取gist特征,
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Cambridge_color_9_5entropy\together\' ;
%  % 54 熵极值法关键5帧每帧提取vlbp特征,
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_5entropy\together\' ; 
 % 55 熵极值法关键5帧每帧提取lbp-top + gist,
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\cam_lbp_top+gist\' ; 
 % 56 熵极值法关键5帧每帧提取vlbp + gist,
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\cam_vlbp+gist\' ; 
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\cam_sift3d+gist\';
 % 57 熵极值法关键4帧每帧提取surf特征,然后每类生成一个字典，每帧用BoW表示再拼接，BoW字典为1,2,4,8,16,32,64,128,256,512,1024,2048,4096
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_6entropy_4096\' ;
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_9entropy_4096\' ;

subdir = dir( maindir );   % 先确定子文件夹
num_class_train = 20;
num_class_test =100-num_class_train;
train_data =[];
test_data =[];
train_label=[];
test_label=[];
num_in_class =[];
% Each row is a data instance.
for class_num = 1:9
    train_label = [train_label; class_num*ones(num_class_train, 1)];
    test_label = [test_label; class_num*ones(num_class_test, 1)];
    num_in_class=[num_in_class; num_class_test]; % 用于最后画混淆矩阵
end

%% predict
nRunning=20;
addpath(genpath('liblinear'))
addpath(genpath('spams-matlab'))
addpath(genpath('PCA'))
tic
for running_times = 1:nRunning    
    train_data=[]; test_data=[];
    rand_num=randperm(num_class_train+num_class_test);                             % 随机选取训练和特使样本
    rand_num= rand_num';                                                           % randi产生的数有重复 randperm产生无重复的整数
    index_train = rand_num(1:num_class_train,:);
    index_test = rand_num(num_class_train + 1:num_class_train+num_class_test,:);
    
    for i = 1 : length( subdir )
        if( isequal( subdir( i ).name, '.' ) || ...
            isequal( subdir( i ).name, '..' ) )   % 如果不是目录跳过
            continue;
        end
        matpath = fullfile( maindir, subdir( i ).name );
        matdata = load( matpath );   % 这里进行你的读取操作
       
        % 适合于 8，9，13,14,15,16,17,18
        train_data = [train_data; matdata.feature(index_train, :)];
        test_data = [test_data; matdata.feature(index_test, :)]; 
        
        
        % 适合于7,10,11,12
%         train_data = [train_data; matdata.BoW_rootSIFT(index_train, :)];
%         test_data = [test_data; matdata.BoW_rootSIFT(index_test, :)];  
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% 归一化预处理
% [train_data,test_data] = scaleForSVM(train_data,test_data);   

%     %% PCA 降维
%     fea_train = train_data;
%     fea_test = test_data;
%     options=[];
%     options.ReducedDim=500;
%     [eigvector_train,eigvalue_train] = PCA(fea_train,options);
%     [eigvector_test,eigvalue_test] = PCA(fea_test,options);
%     train_data = fea_train*eigvector_train;
%     test_data = fea_test*eigvector_test;

% [train_data,test_data] = pcaForSVM(train_data,test_data, 98); % 保存90%的分量
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
    %% liblinear
%     %options = ['-c' num2str(c)];
    model = train(double(train_label), sparse(double(train_data)), '-c 1');
    [predict_label(:, running_times), accuracy, dec_values] = predict(double(test_label), sparse(double(test_data)), model);
    Accuracy(running_times) = accuracy(1);
    
    %% NN classifier
%     addpath(genpath('NNClassifier'))
%     [accuracy,predict_label(:, running_times)] = NNClassifier(train_data',test_data',train_label',test_label'); 
%     Accuracy(running_times) = accuracy;

    %% libsvm 速度太慢了
%     addpath(genpath('libsvm-3.20'))
%     [bestacc,bestc,bestg]=SVMcgForClass(train_label,train_data,-10,10,-10,10,5,0.5,0.5);
%     cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
%     model = svmtrain(train_label, train_data,cmd);
% 
%     [predict_label(:, running_times),accuracy,decision_values] = svmpredict(test_label, test_data, model);
%     Accuracy(running_times) =accuracy(1);
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    str = sprintf('loop: %d --> ratio: %6.4f', running_times, Accuracy(running_times));
    disp(str) 
end
toc
    acc = Accuracy;  
    acc_mean = mean(acc)
    acc_std=std(acc) 

%% plot
% name_class={'FlatLeft', 'FlatRight', 'FlatCont', 'SpreLeft', 'SpreRight', 'SpreCont', 'VLeft', 'VRight', 'VCont'};
% addpath(genpath('Compute_confusion_matrix'))
% max_id = find(acc==max(acc)); %用识别率最高一组数据画混淆矩阵
% if size(max_id,2)>1
%     max_id = max_id(1);
% end
% % num_in_class: 每类测试的数量
% [confusion_matrix]=compute_confusion_matrix(predict_label(:,max_id),num_in_class,name_class);
