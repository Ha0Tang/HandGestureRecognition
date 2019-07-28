clc; clear all; warning off;tic
addpath('functions')
maindir = './datasets/example';
savedir = './datasets/example_keyframe';

subdir =  dir( maindir );
X=[];
for i = 1 : length( subdir )
    if( isequal( subdir( i ).name, '.' ) || ...
        isequal( subdir( i ).name, '..' ) || ...
        ~subdir( i ).isdir )
        continue;
    end
     
    subdirpath = fullfile( maindir, subdir( i ).name);   
    subsubdirpath = dir( subdirpath );
    
	for j = 1 : length( subsubdirpath )
        if( isequal( subsubdirpath( j ).name, '.' ) || ...
            isequal( subsubdirpath( j ).name, '..' ))
            continue;
        end
            sequenc = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name);
            newsubsubdirpath=subsubdirpath( j ).name;
            subsubsubdirpath =dir(sequenc);
            frame_num =  size(subsubsubdirpath,1);
            for k=1:frame_num-2
                image_path = fullfile( maindir, subdir( i ).name, subsubdirpath( j ).name, subsubsubdirpath(k+2).name);
                I=imread(image_path);
                image_entropy=entropy(I);
                X(k)=image_entropy;
            end
            
            y=X;             
            [max,max_label]=findpeaks(y);
            [min,min_label]=findpeaks(-y);
            xlabel_ = [max_label, min_label];
            xlabel_new = [xlabel_, 1, frame_num-2];
            xlabel_new = sort(xlabel_new);
            ylabel_new = y( xlabel_new );
            point_data = [xlabel_new ; ylabel_new];
            point_data = point_data';
          
            key_frames_labels = cluster_dp(point_data);
            
            for k=1:length(key_frames_labels)
                filename = fullfile(savedir, subdir( i ).name, newsubsubdirpath,'/');
                if ~isfolder(filename)
                    mkdir(filename);
                end
                key_image_filename = fullfile(maindir, subdir( i ).name, subsubdirpath(j).name, sprintf('%02d.jpg', key_frames_labels(k))); %Action3D
                copyfile(key_image_filename, filename);
            end
                X =[];
	end
end      
toc



