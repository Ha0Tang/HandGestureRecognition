colordef white


%% 手动选取平均的5帧
% clc; clear all; tic
% addpath('functions')
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_frames';
% % savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_frames_5keyframes';
% 
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\RS-HGD_color_12_frames';
% % savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\RS-HGD_color_12_frames_manual';
% 
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\CVRR_HANDS_19_frames';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\CVRR_HANDS_19_frames_5_manual';
% 
% subdir =  dir( maindir );   % 先确定子文件夹
%  
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' ) || ...
%         isequal( subdir( i ).name, '..' ) || ...
%         ~subdir( i ).isdir )   % 如果不是目录跳过
%         continue;
%     end
%      
%     subdirpath = fullfile( maindir, subdir( i ).name);   
%     subsubdirpath = dir( subdirpath );
%     
%     for j = 1 : length( subsubdirpath )
%         if( isequal( subsubdirpath( j ).name, '.' ) || ...
%             isequal( subsubdirpath( j ).name, '..' ) || ...
%             ~subsubdirpath( j ).isdir )   % 如果不是目录跳过
%             continue;
%         end
%  
%         subsubsubdirpath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, '*.jpg' )
%         images = dir( subsubsubdirpath );   % 在这个子文件夹下找后缀为jpg的文件
% 
%         imagenum = length( images )
%         for k = 1 : imagenum
%             imagepath = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, images( k ).name  )
%             imgdata = imread( imagepath );   % 这里进行你的读取操作
%             if (k==1 || k==imagenum || k==1+round((imagenum-1)/4) || k==1+round((imagenum-1)*2/4) || k==1+round((imagenum-1)*3/4)) 
%                 fpath = fullfile(savedir, subdir( i ).name, subsubdirpath( j ).name);
%                 if ~isdir(fpath),
%                     mkdir(fpath);
%                 end;
%                 copyfile(imagepath, fpath);
%             end
%         end
%     end;
% end
% toc

%% 直方图相邻帧差法
% clc; clear all; tic
% addpath('functions')
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10';
% % 阈值设置为mean
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_mean_2';
% % 阈值设置为mean+std
% % savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_std+mean';
% subdir =  dir( maindir );   % 先确定子文件夹
% 
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' ) || ...
%         isequal( subdir( i ).name, '..' ) || ...
%         ~subdir( i ).isdir )   % 如果不是目录跳过
%         continue;
%     end
%      
%     subdirpath = fullfile( maindir, subdir( i ).name);   
%     subsubdirpath = dir( subdirpath );
%     
%     for j = 1 : length( subsubdirpath )
%         if( isequal( subsubdirpath( j ).name, '.' ) || ...
%             isequal( subsubdirpath( j ).name, '..' ))   % 如果不是目录跳过
%             continue;
%         end
%             vid = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name)
%             newsubsubdirpath=subsubdirpath( j ).name;
%             newsubsubdirpath(end-3:end)=[];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %    ->extracts frames one by one
% %    ->histogram difference between two consecutive frames using imhist() and 
% %      imabsdiff()
% %    ->calculate mean and standard deviation of difference and threshold
% %    ->continue till end of video
% %    ->again extracts frames one by one
% %    ->histogram difference between two consecutive frames using imhist() and 
% %      imabsdiff()
% %    ->compare this difference with threshold and if it is greater than threshold     
% %       select it as a key frame
% %    ->continue till end of video
% 
%             readerobj =  VideoReader(vid);
%             for k=1:  readerobj.NumberOfFrames
%                 I=read(readerobj,k);
%                 if(k~= readerobj.NumberOfFrames)
%                     J=read(readerobj,k+1);
%                     sss=absdif(I,J);
%                     X(k)=sss;
%                 end
%             end
%             mean=mean2(X);
%             std=std2(X);
%             threshold=std+mean;
%             frc = 0;
%             numOfFrames = readerobj.NumberOfFrames;
%             figure, plot(1:numOfFrames-1, X, 1:numOfFrames-1, mean*ones(1,numOfFrames-1),'--');
%             for k=1: readerobj.NumberOfFrames
%                 I =  read(readerobj,k);
%                 if(k~=readerobj.NumberOfFrames)
%                     J=   read(readerobj,k+1);
%                     sss=absdif(I,J);
%                     if(sss>mean)
% %                     if(sss>threshold)
%                         frc = frc + 1;
%                         filename = fullfile(savedir, subdir( i ).name, newsubsubdirpath);
%                         if ~isdir(filename),
%                             mkdir(filename);
%                         end
%                         newfilename = fullfile(savedir, subdir( i ).name, newsubsubdirpath, sprintf('frame_%05d.JPG', frc));
%                         imwrite(J, newfilename);
%                     end
%                 end
%             end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%     end
% end
% toc

%% 熵相邻帧差法
% clc; clear all; tic
% addpath('functions')
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_entropy';
% 
% subdir =  dir( maindir );   % 先确定子文件夹
% 
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' ) || ...
%         isequal( subdir( i ).name, '..' ) || ...
%         ~subdir( i ).isdir )   % 如果不是目录跳过
%         continue;
%     end
%      
%     subdirpath = fullfile( maindir, subdir( i ).name);   
%     subsubdirpath = dir( subdirpath );
%     
%     for j = 1 : length( subsubdirpath )
%         if( isequal( subsubdirpath( j ).name, '.' ) || ...
%             isequal( subsubdirpath( j ).name, '..' ))   % 如果不是目录跳过
%             continue;
%         end
%             vid = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name)
%             newsubsubdirpath=subsubdirpath( j ).name;
%             newsubsubdirpath(end-3:end)=[];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%             readerobj =  VideoReader(vid);
%             for k=1:  readerobj.NumberOfFrames
%                 I=read(readerobj,k);
%                 if(k~= readerobj.NumberOfFrames)
%                     J=read(readerobj,k+1);
%                     sss=entropydif(I,J);
%                     X(k)=sss;
%                 end
%             end
%             mean=mean2(X);
%             std=std2(X);
%             alpha = 0;
%             threshold=mean+alpha*std;
%             frc = 0;
%             numOfFrames = readerobj.NumberOfFrames;
%             figure, plot(1:numOfFrames-1, X, 1:numOfFrames-1, threshold*ones(1,numOfFrames-1),'--');
%             for k=1: readerobj.NumberOfFrames
%                 I =  read(readerobj,k);
%                 if(k~=readerobj.NumberOfFrames)
%                     J=   read(readerobj,k+1);
%                     sss=entropydif(I,J);
%                     if(sss>mean)
% %                     if(sss>threshold)
%                         frc = frc + 1;
%                         filename = fullfile(savedir, subdir( i ).name, newsubsubdirpath);
%                         if ~isdir(filename),
%                             mkdir(filename);
%                         end
%                         newfilename = fullfile(savedir, subdir( i ).name, newsubsubdirpath, sprintf('frame_%05d.JPG', frc));
%                         imwrite(J, newfilename);
%                         X =[];
%                     end
%                 end
%             end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%     end
% end
% toc

%% 最大熵法 大于一个阈值的算关键帧
% clc; clear all; tic
% addpath('functions')
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_entropy';
% 
% subdir =  dir( maindir );   % 先确定子文件夹
% 
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' ) || ...
%         isequal( subdir( i ).name, '..' ) || ...
%         ~subdir( i ).isdir )   % 如果不是目录跳过
%         continue;
%     end
%      
%     subdirpath = fullfile( maindir, subdir( i ).name);   
%     subsubdirpath = dir( subdirpath );
%     
%     for j = 1 : length( subsubdirpath )
%         if( isequal( subsubdirpath( j ).name, '.' ) || ...
%             isequal( subsubdirpath( j ).name, '..' ))   % 如果不是目录跳过
%             continue;
%         end
%             vid = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name)
%             newsubsubdirpath=subsubdirpath( j ).name;
%             newsubsubdirpath(end-3:end)=[];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
%             readerobj =  VideoReader(vid);
%             for k=1:  readerobj.NumberOfFrames
%                 if(k~= readerobj.NumberOfFrames+1)
%                     I=read(readerobj,k);
%                     diff=entropy(I);
%                     X(k)=diff;
%                 end
%             end
%             mean=mean2(X);
%             std=std2(X);
%             alpha = 0;
%             threshold=mean+alpha*std;
%             frc = 0;
%             numOfFrames = readerobj.NumberOfFrames;
%             figure, plot(1:numOfFrames, X, 1:numOfFrames, threshold*ones(1,numOfFrames),'--');
%             for k=1: readerobj.NumberOfFrames
%                 if(k~=readerobj.NumberOfFrames)
%                     I =  read(readerobj,k);
%                     diff=entropy(I);
% %                     if(sss>mean)
%                     if(diff>threshold)
%                         frc = frc + 1;
%                         filename = fullfile(savedir, subdir( i ).name, newsubsubdirpath);
%                         if ~isdir(filename),
%                             mkdir(filename);
%                         end
%                         newfilename = fullfile(savedir, subdir( i ).name, newsubsubdirpath, sprintf('frame_%05d.JPG', frc));
%                         imwrite(I, newfilename);
%                         X =[];
%                     end
%                 end
%             end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
%     end
% end
% toc

%% 最大熵法 取极值 针对视频提取关键帧
% clc; clear all; warning off;tic
% addpath('functions')
% 
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\PKUHandGestureDataset_color_12';
% % savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\PKUHandGestureDataset_color_12_frames_6entropy';
% 
% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10';
% % savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_5entropy_cutoff';
%  
% % savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_3entropy';
% % savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_4entropy';
% % savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_5entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_6entropy';
% 
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\01';
% % savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\01_5entropy';
% 
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\RS-HGD_color_12';
% % savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\RS-HGD_color_12_frames_5entropy';
% 
% % maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\CVRR_HANDS_19';
% % savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\CVRR_HANDS_19_frames_5entropy';
% 
% subdir =  dir( maindir );   % 先确定子文件夹
% 
% for i = 1 : length( subdir )
%     if( isequal( subdir( i ).name, '.' ) || ...
%         isequal( subdir( i ).name, '..' ) || ...
%         ~subdir( i ).isdir )   % 如果不是目录跳过
%         continue;
%     end
%      
%     subdirpath = fullfile( maindir, subdir( i ).name);   
%     subsubdirpath = dir( subdirpath );
%     
% 	for j = 1 : length( subsubdirpath )
%         if( isequal( subsubdirpath( j ).name, '.' ) || ...
%             isequal( subsubdirpath( j ).name, '..' ))   % 如果不是目录跳过
%             continue;
%         end
%             vid = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name)
%             newsubsubdirpath=subsubdirpath( j ).name;
%             newsubsubdirpath(end-3:end)=[];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             readerobj =  VideoReader(vid);
%             for k=1:readerobj.NumberOfFrames
%                 I=read(readerobj,k);
%                 image_entropy=entropy(I);
%                 X(k)=image_entropy;
%             end
%             x =1:readerobj.NumberOfFrames;
%             y=X;
% %%%%%%%%%%%%%plot1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %              figure; plot(x,y,':ok','linewidth', 1,'MarkerSize',4,'MarkerFaceColor','k','MarkerEdgeColor','k');
% %              xlabel('Frame', 'FontSize', 14, 'FontWeight','bold'); 
% %             ylabel('Image Entropy', 'FontSize', 14, 'FontWeight','bold'); 
% %             title('Entropy Calculation', 'FontSize', 14, 'FontWeight','bold'); 
% %             set(gca,'XTick',x);
% % %             legend('Time')
% %             grid on
% %             axis([0 27 7.43 7.48])
% %%%%%%%%%%%%%plot1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
%             [max,max_label]=findpeaks(y);
% %             hold on
% %             plot(x(max_label),max,'ro','LineWidth',2)
%             [min,min_label]=findpeaks(-y);
% %             hold on
% %             plot(x(min_label),-min,'ro','LineWidth',2)
%             xlabel_ = [max_label, min_label];
%             xlabel_new = [xlabel_, 1, readerobj.NumberOfFrames];
%             xlabel_new = sort(xlabel_new);
%             ylabel_new = y( xlabel_new );
%             point_data = [xlabel_new ; ylabel_new];
% %             figure; plot(point_data(1,:), point_data(2,:),'ro','LineWidth',2)
%             point_data = point_data';
% %%%%%%%%%%%%%plot2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %              figure; plot(xlabel_new,ylabel_new,':ok','linewidth', 1,'MarkerSize',4,'MarkerFaceColor','k','MarkerEdgeColor','k');
% %              xlabel('Frame', 'FontSize', 14, 'FontWeight','bold'); 
% %             ylabel('Image Entropy', 'FontSize', 14, 'FontWeight','bold'); 
% %              title('Peaks Selection', 'FontSize', 14,'FontWeight','bold'); 
% %             set(gca,'XTick',xlabel_new);
% %             grid on
% %            axis([0 27 7.43 7.48])
% %%%%%%%%%%%%%plot2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
% %             key_frames_labels = cluster_dp_3(point_data)
% %             assert(length(key_frames_labels) ==3, 'There is a error, key_frames_labels ~ = 3');
% %             key_frames_labels = cluster_dp_4(point_data)
% %             assert(length(key_frames_labels) ==4, 'There is a error, key_frames_labels ~ = 4');
% %            key_frames_labels = cluster_dp_5(point_data)
%             key_frames_labels = cluster_dp_6(point_data)
%             
%             for k=1:length(key_frames_labels)
%                 I =  read(readerobj,key_frames_labels(k));
%                 filename = fullfile(savedir, subdir( i ).name, newsubsubdirpath);
%                 if ~isdir(filename)
%                     mkdir(filename);
%                 end
%                 newfilename = fullfile(savedir, subdir( i ).name, newsubsubdirpath, sprintf('frame_%05d.JPG', key_frames_labels(k)));
%                 imwrite(I, newfilename);
%             end
%                 X =[];
%                 fclose('all');
%                 key_frames_labels = [];
% 	end
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
% toc

%% 最大熵法 取极值 针对图像序列提取关键帧
clc; clear all; warning off;tic
addpath('functions')
maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\PKUAction3D_color_6';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\PKUAction3D_color_6_frames_6entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\PKUAction3D_color_6_frames_7entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\PKUAction3D_color_6_frames_8entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\PKUAction3D_color_6_frames_9entropy';
savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\PKUAction3D_color_6_frames_10entropy';

% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\PKUHandGestureDataset_color_12_frames';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\PKUHandGestureDataset_color_12_frames_6entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\PKUHandGestureDataset_color_12_frames_7entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\PKUHandGestureDataset_color_12_frames_8entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\PKUHandGestureDataset_color_12_frames_9entropy';

% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_frames';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_6entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_7entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_8entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Northwestern_color_10_key_frames_max_9entropy';

% maindir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_6entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_7entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_8entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_9entropy';

% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_5entropy_cutoff';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_4entropy';
% savedir = 'F:\Myprojects\matlabProjects\featureExtraction\image_database\Cambridge_color_9_3entropy';

subdir =  dir( maindir );   % 先确定子文件夹

for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )   % 如果不是目录跳过
        continue;
    end
     
    subdirpath = fullfile( maindir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath );
    
	for j = 1 : length( subsubdirpath )
        if( isequal( subsubdirpath( j ).name, '.' ) || ...
            isequal( subsubdirpath( j ).name, '..' ))   % 如果不是目录跳过
            continue;
        end
            sequenc = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name);
            newsubsubdirpath=subsubdirpath( j ).name;
%             newsubsubdirpath(end-3:end)=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            subsubsubdirpath =dir(sequenc);
            frame_num =  size(subsubsubdirpath,1);
            for k=1:frame_num-2
                image_path = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, subsubsubdirpath(k+2).name);
                I=imread(image_path);
                image_entropy=entropy(I);
                X(k)=image_entropy;
            end
            
            y=X;
%%%%%%%%%%%%%plot1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             x =1:frame_num-2;             
%             figure; plot(x,y,':ok','linewidth', 1,'MarkerSize',4,'MarkerFaceColor','k','MarkerEdgeColor','k');
%              xlabel('Frame', 'FontSize', 14, 'FontWeight','bold'); 
%             ylabel('Image Entropy', 'FontSize', 14, 'FontWeight','bold'); 
%             title('Entropy Calculation', 'FontSize', 14, 'FontWeight','bold'); 
%             set(gca,'XTick',x);
% %             legend('Time')
%             grid on
% %             axis([0 27 7.43 7.48])
%%%%%%%%%%%%%plot1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             
            [max,max_label]=findpeaks(y);
%             hold on
%             plot(x(max_label),max,'ro','LineWidth',2)
            [min,min_label]=findpeaks(-y);
%             hold on
%             plot(x(min_label),-min,'ro','LineWidth',2)
            xlabel_ = [max_label, min_label];
            xlabel_new = [xlabel_, 1, frame_num-2];
            xlabel_new = sort(xlabel_new);
            ylabel_new = y( xlabel_new );
            point_data = [xlabel_new ; ylabel_new];
%             figure; plot(point_data(1,:), point_data(2,:),'ro','LineWidth',2)
            point_data = point_data';
%%%%%%%%%%%%%plot2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              figure; plot(xlabel_new,ylabel_new,':ok','linewidth', 1,'MarkerSize',4,'MarkerFaceColor','k','MarkerEdgeColor','k');
%              xlabel('Frame', 'FontSize', 14, 'FontWeight','bold'); 
%             ylabel('Image Entropy', 'FontSize', 14, 'FontWeight','bold'); 
%              title('Peaks Selection', 'FontSize', 14,'FontWeight','bold'); 
%             set(gca,'XTick',xlabel_new);
%             grid on
% %            axis([0 27 7.43 7.48])
%%%%%%%%%%%%%plot2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            
            key_frames_labels = cluster_dp_3(point_data)
%             assert(length(key_frames_labels) ==3, 'There is a error, key_frames_labels ~ = 3');
%             key_frames_labels = cluster_dp_4(point_data)
%             assert(length(key_frames_labels) ==4, 'There is a error, key_frames_labels ~ = 4');
%             key_frames_labels = cluster_dp_5(point_data)
%             key_frames_labels = cluster_dp_6(point_data)
%             key_frames_labels = cluster_dp_7(point_data)
%             key_frames_labels = cluster_dp_8(point_data)
%             key_frames_labels = cluster_dp_9(point_data)
            
            for k=1:length(key_frames_labels)
                filename = fullfile(savedir, subdir( i ).name, newsubsubdirpath,'\');
                if ~isdir(filename)
                    mkdir(filename);
                end

key_image_filename = fullfile(maindir, subdir( i ).name, subsubdirpath(j).name, sprintf('%01d.jpg', key_frames_labels(k))) %PKUAction3D
% key_image_filename = fullfile(maindir, subdir( i ).name, subsubdirpath( j ).name, sprintf('frame-%04d.jpg', key_frames_labels(k))) %Cambridge
% key_image_filename = fullfile(maindir, subdir( i ).name, subsubdirpath( j ).name, sprintf('%03d.jpg', key_frames_labels(k))) %Northwestern,PKUHandGestureDataset
                
copyfile(key_image_filename, filename);
            end
                X =[];
                fclose('all');
	end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
toc

% x =1:numOfFrames;
% y=X;
% plot(x,y)
% [max,max_label]=findpeaks(y);
% hold on
% plot(x(max_label),max,'ro','LineWidth',2)
% [min,min_label]=findpeaks(-y);
% hold on
% plot(x(min_label),-min,'ro','LineWidth',2)
% xlabel = [max_label, min_label];
% xlabel_new = sort(xlabel);
% ylabel_new = y( xlabel_new );
% data = [xlabel_new ; ylabel_new];
% figure; plot(data(1,:), data(2,:))
% for i = 1: length(xlabel_new)
%     before_frame =  xlabel_new(i);
%     if(i~=length(xlabel_new))
%         after_frame= xlabel_new(i+1);
%         image_entropy(i) = before_frame-after_frame;
%     end
% end



