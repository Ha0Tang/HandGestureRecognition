%%  ����0��һ��������together
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
% subdir = dir( maindir );   % ��ȷ�����ļ���
% feature = [];
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' ) || ...
%         isequal( subdir( i ).name, '..' ) || ...
%         ~subdir( i ).isdir )   % �������Ŀ¼����
%         continue;
%     end
%      
%     subdirpath = fullfile( maindir, subdir( i ).name, '*.mat' );
%     mat = dir( subdirpath );   % ��������ļ������Һ�׺Ϊmat���ļ�
%      
%     % ����ÿ��mat�ļ�
%     
%     for j = 1 : length( mat )
%         matpath = fullfile( maindir, subdir( i ).name, mat( j ).name  )
%         matdata = load( matpath );   % ���������Ķ�ȡ����
% %         feature = [feature; matdata.clbpfeature]; % һ����һ������
% %         feature = [feature; matdata.lbpfeature]; % һ����һ������
% %         feature = [feature; matdata.Gistfeature]; % һ����һ������
% %         feature = [feature; matdata.LBP_TOP_Feature]; % һ����һ������
%         feature = [feature; matdata.VLBP_Feature]; % һ����һ������
%     end
%     savepath = fullfile( maindir, subdir( i ).name)
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  together ��ԭʼ3D SIFT��������һ���任
% clc; clear all;
% % ԭʼ�����Ķ���original�ļ�����,��ԭʼ���������Ƶ�together�ļ�����
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Cambridge_color_9_together\' ;
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Cambridge_color_9_5entropy\' ;
% 
% 
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
%     for j=1:100
%         for k=1:200
%             feature(j, (k-1)*640+1:(k-1)*640+640) = matdata.keys{j, k}.ivec;
%         end
%     end
%     savepath = fullfile( maindir, subdir( i ).name)
%     save(savepath, 'feature'); 
% end


%%  ����һ�� �����������ں� lbp-top + ÿ֡gist
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
% sub_lbp_top_dir = dir( main_lbp_top_dir );   % ��ȷ�����ļ���
% sub_gist_dir = dir( main_gist_dir );   % ��ȷ�����ļ���
% feature = [];
% for i = 3 : length( sub_lbp_top_dir )
%     subsub_lbp_top_dir = fullfile( main_lbp_top_dir, sub_lbp_top_dir( i ).name);
%     mat_lbp_top_data = load( subsub_lbp_top_dir );   % ���������Ķ�ȡ����
%     
%     subsub_gist_dir = fullfile( main_gist_dir, sub_gist_dir( i ).name);
%     mat_gist_data = load( subsub_gist_dir );   % ���������Ķ�ȡ����
%     feature = [mat_lbp_top_data.feature, mat_gist_data.feature]; % һ����һ������
%     
%     savepath = fullfile( save_dir, sub_lbp_top_dir( i ).name)
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  �������� �����������ں� vlbp + ÿ֡gist
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
% sub_vlbp_dir = dir( main_vlbp_dir );   % ��ȷ�����ļ���
% sub_gist_dir = dir( main_gist_dir );   % ��ȷ�����ļ���
% feature = [];
% for i = 3 : length( sub_vlbp_dir )
%     subsub_vlbp_dir = fullfile( main_vlbp_dir, sub_vlbp_dir( i ).name);
%     mat_vlbp_data = load( subsub_vlbp_dir );   % ���������Ķ�ȡ����
%     
%     subsub_gist_dir = fullfile( main_gist_dir, sub_gist_dir( i ).name);
%     mat_gist_data = load( subsub_gist_dir );   % ���������Ķ�ȡ����
%     feature = [mat_vlbp_data.feature, mat_gist_data.feature]; % һ����һ������
%     
%     savepath = fullfile( save_dir, sub_vlbp_dir( i ).name)
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  �������� �����������ں� vlbp + ��������BoW rootSIFT
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
% sub_vlbp_dir = dir( main_vlbp_dir );   % ��ȷ�����ļ���
% sub_rootSIFT_dir = dir( main_rootSIFT_dir );   % ��ȷ�����ļ���
% feature = [];
% for i = 3 : length( sub_vlbp_dir )
%     subsub_vlbp_dir = fullfile( main_vlbp_dir, sub_vlbp_dir( i ).name);
%     mat_vlbp_data = load( subsub_vlbp_dir );   % ���������Ķ�ȡ����
%     
%     subsub_gist_dir = fullfile( main_rootSIFT_dir, sub_rootSIFT_dir( i ).name);
%     mat_rootSIFT_data = load( subsub_gist_dir );   % ���������Ķ�ȡ����
%     feature = [mat_vlbp_data.feature, mat_rootSIFT_data.BoW_rootSIFT]; % һ����һ������
%     
%     savepath = fullfile( save_dir, sub_vlbp_dir( i ).name)
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  �����ģ� �����������ں� lbp-top + ��������BoW rootSIFT
% clc; clear all;
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+BoW-rootSIFT';
% main_lbp_top_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_keyframe\together\' ;
% main_rootSIFT_dir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW\' ;
% sub_lbp_top_dir = dir( main_lbp_top_dir );   % ��ȷ�����ļ���
% sub_rootSIFT_dir = dir( main_rootSIFT_dir );   % ��ȷ�����ļ���
% feature = [];
% for i = 3 : length( sub_lbp_top_dir )
%     subsub_lbp_top_dir = fullfile( main_lbp_top_dir, sub_lbp_top_dir( i ).name);
%     mat_lbp_top_data = load( subsub_lbp_top_dir );   % ���������Ķ�ȡ����
%     
%     subsub_gist_dir = fullfile( main_rootSIFT_dir, sub_rootSIFT_dir( i ).name);
%     mat_rootSIFT_data = load( subsub_gist_dir );   % ���������Ķ�ȡ����
%     feature = [mat_lbp_top_data.feature, mat_rootSIFT_data.BoW_rootSIFT]; % һ����һ������
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     savepath = fullfile( save_dir, sub_lbp_top_dir( i ).name)
% 
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  ����5�� �����������ں� lbp-top + ÿ֡BoW rootSIFT��ʾ
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
% sub_lbp_top_dir = dir( main_lbp_top_dir );   % ��ȷ�����ļ���
% sub_rootSIFT_dir = dir( main_rootSIFT_dir );   % ��ȷ�����ļ���
% feature = [];
% for i = 3 : length( sub_lbp_top_dir )
%     subsub_lbp_top_dir = fullfile( main_lbp_top_dir, sub_lbp_top_dir( i ).name);
%     mat_lbp_top_data = load( subsub_lbp_top_dir );   % ���������Ķ�ȡ����
%     
%     subsub_gist_dir = fullfile( main_rootSIFT_dir, sub_rootSIFT_dir( i ).name);
%     mat_rootSIFT_data = load( subsub_gist_dir );   % ���������Ķ�ȡ����
%     feature = [mat_lbp_top_data.feature, mat_rootSIFT_data.feature]; % һ����һ������
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     savepath = fullfile( save_dir, sub_lbp_top_dir( i ).name)
% 
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  ����6�� �����������ں� vlbp + ÿ֡BoW rootSIFT��ʾ
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
% sub_vlbp_dir = dir( main_vlbp_dir );   % ��ȷ�����ļ���
% sub_rootSIFT_dir = dir( main_rootSIFT_dir );   % ��ȷ�����ļ���
% feature = [];
% for i = 3 : length( sub_vlbp_dir )
%     subsub_vlbp_dir = fullfile( main_vlbp_dir, sub_vlbp_dir( i ).name);
%     mat_vlbp_data = load( subsub_vlbp_dir );   % ���������Ķ�ȡ����
%     
%     subsub_rootSIFT_dir = fullfile( main_rootSIFT_dir, sub_rootSIFT_dir( i ).name);
%     mat_rootSIFT_data = load( subsub_rootSIFT_dir );   % ���������Ķ�ȡ����
%     feature = [mat_vlbp_data.feature, mat_rootSIFT_data.feature]; % һ����һ������
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     savepath = fullfile( save_dir, sub_vlbp_dir( i ).name)
% 
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  ����7�� �ؼ�֡ÿ֡ HSV + LBP
% clc; clear all;
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp+hsv';
% main_lbp_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe\together\' ;;
% main_hsv_dir = 'F:\Myprojects\matlabProjects\featureExtraction\hsv_feature\Cambridge_color_9_keyframe\together\' ;
% sub_lbp_dir = dir( main_lbp_dir );   % ��ȷ�����ļ���
% sub_hsv_dir = dir( main_hsv_dir );   % ��ȷ�����ļ���
% feature = [];
% for i = 3 : length( sub_lbp_dir )
%     subsub_lbp_dir = fullfile( main_lbp_dir, sub_lbp_dir( i ).name);
%     mat_lbp_data = load( subsub_lbp_dir );   % ���������Ķ�ȡ����
%     
%     subsub_hsv_dir = fullfile( main_hsv_dir, sub_hsv_dir( i ).name);
%     mat_hsv_data = load( subsub_hsv_dir );   % ���������Ķ�ȡ����
%     feature = [mat_lbp_data.feature, mat_hsv_data.feature]; % һ����һ������
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     savepath = fullfile( save_dir, sub_lbp_dir( i ).name)
% 
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  ����8�� �ؼ�֡ÿ֡ vlbp + LBP
% clc; clear all;
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+lbp';
% main_lbp_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe\together\' ;;
% main_vlbp_dir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_keyframe\together\' ;
% sub_lbp_dir = dir( main_lbp_dir );   % ��ȷ�����ļ���
% sub_vlbp_dir = dir( main_vlbp_dir );   % ��ȷ�����ļ���
% feature = [];
% for i = 3 : length( sub_lbp_dir )
%     subsub_lbp_dir = fullfile( main_lbp_dir, sub_lbp_dir( i ).name);
%     mat_lbp_data = load( subsub_lbp_dir );   % ���������Ķ�ȡ����
%     
%     subsub_vlbp_dir = fullfile( main_vlbp_dir, sub_vlbp_dir( i ).name);
%     mat_vlbp_data = load( subsub_vlbp_dir );   % ���������Ķ�ȡ����
%     feature = [mat_lbp_data.feature, mat_vlbp_data.feature]; % һ����һ������
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     savepath = fullfile( save_dir, sub_lbp_dir( i ).name)
% 
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%  ����9�� �ؼ�֡ÿ֡ lbp_top + LBP
% clc; clear all;
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp_top+lbp';
% main_lbp_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe\together\' ;;
% main_lbp_top_dir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_keyframe\together\' ;
% sub_lbp_dir = dir( main_lbp_dir );   % ��ȷ�����ļ���
% sub_lbp_top_dir = dir( main_lbp_top_dir );   % ��ȷ�����ļ���
% feature = [];
% for i = 3 : length( sub_lbp_dir )
%     subsub_lbp_dir = fullfile( main_lbp_dir, sub_lbp_dir( i ).name);
%     mat_lbp_data = load( subsub_lbp_dir );   % ���������Ķ�ȡ����
%     
%     subsub_lbp_top_dir = fullfile( main_lbp_top_dir, sub_lbp_top_dir( i ).name);
%     mat_lbp_top_data = load( subsub_lbp_top_dir );   % ���������Ķ�ȡ����
%     feature = [mat_lbp_data.feature, mat_lbp_top_data.feature]; % һ����һ������
%     newfold = fullfile( save_dir);
%     if ~isdir(newfold),
%         mkdir(newfold);
%     end;
%     savepath = fullfile( save_dir, sub_lbp_dir( i ).name)
% 
%     save(savepath, 'feature'); 
%     feature = [];
% end


%%  ����10�� �����������ں� SIFT 3D + ÿ֡gist
% clc; clear all;
% save_dir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\cam_sift3d+gist';
% main_sift3d_dir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Cambridge_color_9_5entropy\' ;
% main_gist_dir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Cambridge_color_9_5entropy\together\' ;
% 
% sub_vlbp_dir = dir( main_sift3d_dir );   % ��ȷ�����ļ���
% sub_gist_dir = dir( main_gist_dir );   % ��ȷ�����ļ���
% feature = [];
% for i = 3 : length( sub_vlbp_dir )
%     subsub_vlbp_dir = fullfile( main_sift3d_dir, sub_vlbp_dir( i ).name);
%     mat_vlbp_data = load( subsub_vlbp_dir );   % ���������Ķ�ȡ����
%     
%     subsub_gist_dir = fullfile( main_gist_dir, sub_gist_dir( i ).name);
%     mat_gist_data = load( subsub_gist_dir );   % ���������Ķ�ȡ����
%     feature = [mat_vlbp_data.feature, mat_gist_data.feature]; % һ����һ������
%     
%     savepath = fullfile( save_dir, sub_vlbp_dir( i ).name)
%     save(savepath, 'feature'); 
%     feature = [];
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% ��ִ������ĳ�����ִ������ĳ���
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% train and test data
clc; clear all;
% % 1 ����Cambridge���ݿ⣬ÿ�������͵�������ȡlbp-top����
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9\together\' ;
% % 2 ����Cambridge���ݿ⣬ÿ�������͵����У����ȵõ��ؼ�֡���ٶԹؼ�֡��ȡlbp-top����
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_keyframe\together\' ;
% % 3 ����Cambridge���ݿ⣬ÿ�������͵�������ȡvlbp����
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9\together\' ;
% % 4 ����Cambridge���ݿ⣬ÿ�������͵����У����ȵõ��ؼ�֡���ٶԹؼ�֡��ȡvlbp����
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_keyframe\together\' ;
% % 5 �ؼ�5֡��ȡlbp-top��ͬʱÿ֡��ȡgist����
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp_top+gist\' ;
% % 6 �ؼ�5֡��ȡvlbp��ͬʱÿ֡��ȡgist����
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+gist\' ;
 % 7 ֻ�ùؼ�5֡����ȡrootSIFT����������ÿ���Լ��ľ��࣬����ÿ���Լ����ֵ䣬ÿ���ֵ��С1024
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_1024\' ;
 % 8 ֻ�ùؼ�5֡��������5֡��ȡVLBP����������5֡�е�ÿһ֡����rootSIFT����������ÿ���Լ��ľ��࣬����ÿ���Լ����ֵ䣬ÿ���ֵ��С1024
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+BoW-rootSIFT\' ;
 % 9 ֻ�ùؼ�5֡��������5֡��ȡLBP-TOP����������5֡�е�ÿһ֡����rootSIFT����������ÿ���Լ��ľ��࣬����ÿ���Լ����ֵ䣬ÿ���ֵ��С1024
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+BoW-rootSIFT\' ;
 % 10 ֻ�ùؼ�5֡������5֡�е�ÿһ֡��ȡrootSIFT����������ÿ���Լ��ľ��࣬����ÿ���Լ����ֵ䣬ÿ���ֵ��С512
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_512\' ;
 % 11 ֻ�ùؼ�5֡������5֡�е�ÿһ֡��ȡrootSIFT����������ÿ���Լ��ľ��࣬����ÿ���Լ����ֵ䣬ÿ���ֵ��С128
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_128\' ;
 % 12 ֻ�ùؼ�5֡������5֡�е�ÿһ֡��ȡrootSIFT����������ÿ���Լ��ľ��࣬����ÿ���Լ����ֵ䣬ÿ���ֵ��С256
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_256\' ;
 % 13 ֻ�ùؼ�5֡������5֡��ȡvlbp����������5֡�е�ÿһ֡��ȡrootSIFT����������ÿ���Լ��ľ��࣬����ÿ���Լ����ֵ䣬ÿ���ֵ��С512
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+BoW-rootSIFT-512\' ;
 % 14 ֻ�ùؼ�5֡������5֡��ȡvlbp����������5֡�е�ÿһ֡��ȡrootSIFT����������ÿ���Լ��ľ��࣬����ÿ���Լ����ֵ䣬ÿ���ֵ��С256
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+BoW-rootSIFT-256\' ;
 % 15 ֻ�ùؼ�5֡������5֡��ȡvlbp����������5֡�е�ÿһ֡��ȡrootSIFT����������ÿ���Լ��ľ��࣬����ÿ���Լ����ֵ䣬ÿ���ֵ��С128
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+BoW-rootSIFT-128\' ;
 % 16 ֻ�ùؼ�5֡������5֡�е�ÿһ֡��ȡrootSIFT����������ÿ���Լ��ľ��࣬����ÿ���Լ����ֵ䣬ÿ���ֵ��С128,
 % ÿ��ͼƬ��BoW������ʾ��Ȼ����ƴ����һ��һ��128*5=640ά
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_128\' ;
 % 17 ��16��� ֻ��ά�ȱ����64*5=320ά
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_64\' ;
 % 18 ��16��� ֻ��ά�ȱ����256*5=1280ά
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_256\' ;
 % 19 ��16��� ֻ��ά�ȱ����512*5=2560ά
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\sift_feature\Cambridge_color_9_keyframe_gray_BoW_split_512\' ;
 % 20 �ؼ�֡lbp-top + ÿ֡��ȡBoW rootSIFT������ƴ�� ÿ���ֵ�512
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+split_BoW-rootSIFT_512\' ;
 % 21 �ؼ�֡lbp-top + ÿ֡��ȡBoW rootSIFT������ƴ�� ÿ���ֵ�256
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+split_BoW-rootSIFT_256\' ;
 % 22 �ؼ�֡lbp-top + ÿ֡��ȡBoW rootSIFT������ƴ�� ÿ���ֵ�128
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+split_BoW-rootSIFT_128\' ;
 % 22 �ؼ�֡lbp-top + ÿ֡��ȡBoW rootSIFT������ƴ�� ÿ���ֵ�64
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp-top+split_BoW-rootSIFT_64\' ;
 % 23 �ؼ�֡vlbp + ÿ֡��ȡBoW rootSIFT������ƴ�� ÿ���ֵ�64
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+split_BoW-rootSIFT_64\' ;
 % 24 �ؼ�֡vlbp + ÿ֡��ȡBoW rootSIFT������ƴ�� ÿ���ֵ�128
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+split_BoW-rootSIFT_128\' ;
 % 25 �ؼ�֡vlbp + ÿ֡��ȡBoW rootSIFT������ƴ�� ÿ���ֵ�256
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+split_BoW-rootSIFT_256\' ;
 % 26 �ؼ�֡vlbp + ÿ֡��ȡBoW rootSIFT������ƴ�� ÿ���ֵ�512
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+split_BoW-rootSIFT_512\' ;
 % 27 �ؼ�֡ÿ֡��ȡ1000άHSV����
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\hsv_feature\Cambridge_color_9_keyframe\together\' ;
 % 28 �ؼ�֡ÿ֡��ȡ512άGist����
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Cambridge_color_9_keyframe\together\' ;
 % 29 �ؼ�֡ÿ֡��ȡ59άlbp��u2������
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe\together\' ;
 % 30 �ؼ�֡ÿ֡��ȡlbp��u2��+hsv����
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp+hsv\' ;
 % 31 �ؼ�֡ÿ֡��ȡlbp(riu2ģʽ)����
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe_riu2\together\' ;
 % 32 �ؼ�֡ÿ֡��ȡlbp(riģʽ)����
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_feature\Cambridge_color_9_keyframe_ri\together\' ;
 % 33 �ؼ�֡ÿ֡��ȡvlbp+lbp(u2ģʽ)����
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\vlbp+lbp\' ;
 % 34 �ؼ�֡ÿ֡��ȡlbp-top+lbp(u2ģʽ)����
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\lbp_top+lbp\' ;
 % 35 �ؼ�֡ÿ֡��ȡclbp(u2ģʽ)����
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\clbp_feature\Cambridge_color_9_keyframe_u2\together\' ;
 % 36 �ؼ�֡ÿ֡��ȡsurf����, Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ512
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_512\' ;
 % 37 �ؼ�֡ÿ֡��ȡsurf����, Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ64
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_64\' ;
 % 38 �ؼ�֡ÿ֡��ȡsurf����, Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ8
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_8\' ;
 % 39 �ؼ�֡ÿ֡��ȡsurf����, Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ2
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_2\' ;
 % 40 �ؼ�֡ÿ֡��ȡsurf����, Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ1
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_1\' ;
 % 41 �ؼ�֡ÿ֡��ȡsurf����, Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ3
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_3\' ;
 % 42 �ؼ�֡ÿ֡��ȡsurf����, Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ4
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_4\' ;
 % 43 �ؼ�֡ÿ֡��ȡsurf����, Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ5
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_5\' ;
 % 44 �ؼ�֡ÿ֡��ȡsurf����, Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ10
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_10\' ;
 % 45 �ؼ�֡ÿ֡��ȡsurf����, Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ20
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_20\' ;
 % 46 �ؼ�֡ÿ֡��ȡsurf����, Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ15
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_15\' ;
 % 46 �ؼ�֡ÿ֡��ȡsurf����, Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ128
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_128\' ;
 % 47 �ؼ�֡ÿ֡��ȡsurf����, Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ256
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_keyframe_BoW_split_256\' ;
 % 48 �ؼ�֡ÿ֡��ȡhog���� ���Լ��������ܻ��ڴ����
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\hog_feature\Cambridge_color_9_keyframe_2_2\' ; 
 % 49 ��ȡ3D SIFT���� ÿ���������ѡ��200����
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\3Dsift_feature\Cambridge_color_9_together\' ; 
 % 50 �Լ�ֵ����ȡ�Ĺؼ�5֡����ȡlbp-top����
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\lbp_top_feature\Cambridge_color_9_5entropy\together\' ; 
 % 51 �ؼ�ֵ���ؼ�3֡ÿ֡��ȡsurf����,
 % Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ1,2��4,8,16,32,64,128,256,512,1024,2048,4096
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_3entropy_4096\' ;
 % 52 �ؼ�ֵ���ؼ�4֡ÿ֡��ȡsurf����,
 % Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ1,2��4,8,16,32,64,128,256,512,1024,2048,4096
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_4entropy_4096\' ;
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_5entropy_1\' ;
 % 52 �ؼ�ֵ���ؼ�5֡ÿ֡��ȡsurf����,
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_5entropy_cutoff_64\' ; 
 % 53 �ؼ�ֵ���ؼ�5֡ÿ֡��ȡgist����,
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\gist_feature\Cambridge_color_9_5entropy\together\' ;
%  % 54 �ؼ�ֵ���ؼ�5֡ÿ֡��ȡvlbp����,
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\vlbp_feature\Cambridge_color_9_5entropy\together\' ; 
 % 55 �ؼ�ֵ���ؼ�5֡ÿ֡��ȡlbp-top + gist,
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\cam_lbp_top+gist\' ; 
 % 56 �ؼ�ֵ���ؼ�5֡ÿ֡��ȡvlbp + gist,
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\cam_vlbp+gist\' ; 
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\Combination feature\cam_sift3d+gist\';
 % 57 �ؼ�ֵ���ؼ�4֡ÿ֡��ȡsurf����,Ȼ��ÿ������һ���ֵ䣬ÿ֡��BoW��ʾ��ƴ�ӣ�BoW�ֵ�Ϊ1,2,4,8,16,32,64,128,256,512,1024,2048,4096
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_6entropy_4096\' ;
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\surf_feature\Cambridge_color_9_9entropy_4096\' ;

subdir = dir( maindir );   % ��ȷ�����ļ���
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
    num_in_class=[num_in_class; num_class_test]; % ������󻭻�������
end

%% predict
nRunning=20;
addpath(genpath('liblinear'))
addpath(genpath('spams-matlab'))
addpath(genpath('PCA'))
tic
for running_times = 1:nRunning    
    train_data=[]; test_data=[];
    rand_num=randperm(num_class_train+num_class_test);                             % ���ѡȡѵ������ʹ����
    rand_num= rand_num';                                                           % randi�����������ظ� randperm�������ظ�������
    index_train = rand_num(1:num_class_train,:);
    index_test = rand_num(num_class_train + 1:num_class_train+num_class_test,:);
    
    for i = 1 : length( subdir )
        if( isequal( subdir( i ).name, '.' ) || ...
            isequal( subdir( i ).name, '..' ) )   % �������Ŀ¼����
            continue;
        end
        matpath = fullfile( maindir, subdir( i ).name );
        matdata = load( matpath );   % ���������Ķ�ȡ����
       
        % �ʺ��� 8��9��13,14,15,16,17,18
        train_data = [train_data; matdata.feature(index_train, :)];
        test_data = [test_data; matdata.feature(index_test, :)]; 
        
        
        % �ʺ���7,10,11,12
%         train_data = [train_data; matdata.BoW_rootSIFT(index_train, :)];
%         test_data = [test_data; matdata.BoW_rootSIFT(index_test, :)];  
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
% ��һ��Ԥ����
% [train_data,test_data] = scaleForSVM(train_data,test_data);   

%     %% PCA ��ά
%     fea_train = train_data;
%     fea_test = test_data;
%     options=[];
%     options.ReducedDim=500;
%     [eigvector_train,eigvalue_train] = PCA(fea_train,options);
%     [eigvector_test,eigvalue_test] = PCA(fea_test,options);
%     train_data = fea_train*eigvector_train;
%     test_data = fea_test*eigvector_test;

% [train_data,test_data] = pcaForSVM(train_data,test_data, 98); % ����90%�ķ���
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

    %% libsvm �ٶ�̫����
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
% max_id = find(acc==max(acc)); %��ʶ�������һ�����ݻ���������
% if size(max_id,2)>1
%     max_id = max_id(1);
% end
% % num_in_class: ÿ����Ե�����
% [confusion_matrix]=compute_confusion_matrix(predict_label(:,max_id),num_in_class,name_class);
