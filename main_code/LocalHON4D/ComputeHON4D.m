%% Read depth sequence
clc,clear,close all;
% filename_depth = 'a01_s01_e01_depth.bin';
filename_depth = 'sub_depth_01_20.mat';
data = load(filename_depth);
depth = data.depth_part;

% % Read the depth sequence
% [depth, skeleton_mask] =  ReadDepthBin(filename_depth);

% % If the depth sequence is not stored in a bin file, you can comment the
% % above line, and uncomment the lines below to read an avi file.

% filename_depth = 'S1_C1_U1_E1.oni_Depth.avi';
% avif = VideoReader(filename_depth);
% depth = double(zeros(avif.Height,avif.Width,avif.NumberOfFrames));
% for i=1:avif.NumberOfFrames
%     frame = read(avif,i);
%     depth(:,:,i) = double(rgb2gray(frame));
%     disp(i);
% end

% compute derivatives of depth
num_frames = size(depth,3);
gx =zeros(size(depth,1),size(depth,2),size(depth,3)-1);
gy =zeros(size(depth,1),size(depth,2),size(depth,3)-1);
gz =zeros(size(depth,1),size(depth,2),size(depth,3)-1);
for indFrame=1:num_frames-1
    im1 = medfilt2(depth(:,:,indFrame), [5 5]);
    im2 = medfilt2(depth(:,:,indFrame+1), [5 5]);
    [dx,dy,dz] = gradient(cat(3,im1,im2),1,1,1);
    
    gx(:,:,indFrame) = dx(:,:,1);
    gy(:,:,indFrame) = dy(:,:,1);
    gz(:,:,indFrame) = dz(:,:,1);
end


%% Compute HON4D 

% HON4D parameters
DIM = 120; % number of 4D projectors
P = loadProjector('000.txt',DIM);
cell = [];
cell.numR = 3;
cell.numC = 3;
cell.numD = 1;
cell.width = 12;
cell.height = 12;
cell.depth = 4;
cell.DIM = DIM;

% Find HON4D for an example point at coordinates [center_x,center_y] at depth frame number f
% center_x = 162;
% center_y = 95;
center_x = 17;
center_y = 41;
f=45; %帧数至少从3开始
center_z = -1; % not used
feature_right = get_honv4_feature(f,gx,gy,gz, center_x,center_y, center_z, cell,P);





