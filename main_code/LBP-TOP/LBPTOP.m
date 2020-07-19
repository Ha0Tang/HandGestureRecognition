function Histogram = LBPTOP(VolData, FxRadius, FyRadius, TInterval, NeighborPoints, TimeLength, BorderLength, bBilinearInterpolation, Bincount, Code)
%  This function is to compute the LBP-TOP features for a video sequence
%  Reference:
%  Guoying Zhao, Matti Pietikainen, "Dynamic texture recognition using local binary patterns
%  with an application to facial expressions," IEEE Transactions on Pattern Analysis and Machine
%  Intelligence, 2007, 29(6):915-928.
%
%   Copyright 2009 by Guoying Zhao & Matti Pietikainen
%   Matlab version was Created by Xiaohua Huang
%  If you have any problem, please feel free to contact guoying zhao or Xiaohua Huang.
% huang.xiaohua@ee.oulu.fi
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Function: Running this funciton each time to compute the LBP-TOP distribution of one video sequence.
%
%  Inputs:
%
%  "VolData" keeps the grey level of all the pixels in sequences with [height][width][Length];
%       please note, all the images in one sequnces should have same size (height and weight).
%       But they don't have to be same for different sequences.
%
%  "FxRadius", "FyRadius" and "TInterval" are the radii parameter along X, Y and T axis; They can be 1, 2, 3 and 4. "1" and "3" are recommended.
%  Pay attention to "TInterval". "TInterval * 2 + 1" should be smaller than the length of the input sequence "Length". For example, if one sequence includes seven frames, and you set TInterval to three, only the pixels in the frame 4 would be considered as central pixel and computed to get the LBP-TOP feature.
%
%
%  "NeighborPoints" is the number of the neighboring points
%      in XY plane, XT plane and YT plane; They can be 4, 8, 16 and 24. "8"
%      is a good option. For example, NeighborPoints = [8 8 8];
%
%  "TimeLength" and "BoderLength" are the parameters for bodering parts in time and space which would not
%      be computed for features. Usually they are same to TInterval and the bigger one of "FxRadius" and "FyRadius";
%
%  "bBilinearInterpolation": if use bilinear interpolation for computing a neighboring point in a circle: 1 (yes), 0 (no).
%
%  "Bincount": For example, if XYNeighborPoints = XTNeighborPoints = YTNeighborPoints = 8, you can set "Bincount" as "0" if you want to use basic LBP, or set "Bincount" as 59 if using uniform pattern of LBP,
%              If the number of Neighboring points is different than 8, you need to change it accordingly as well as change the above "Code".
%  "Code": only when Bincount is 59, uniform code is used.
%  Output:
%
%  "Histogram": keeps LBP-TOP distribution of all the pixels in the current frame with [3][dim];
%      here, "3" deote the three planes of LBP-TOP, i.e., XY, XZ and YZ planes.
%      Each value of Histogram[i][j] is between [0,1]

%%
[height width Length] = size(VolData);

XYNeighborPoints = NeighborPoints(1);
XTNeighborPoints = NeighborPoints(2);
YTNeighborPoints = NeighborPoints(3);

if (Bincount == 0)
    % normal code
    nDim = 2^(YTNeighborPoints);
    Histogram = zeros(3, nDim);
else
    % uniform code
    Histogram = zeros(3, Bincount); % Bincount = 59;
end

if (bBilinearInterpolation == 0)
    
    for i = TimeLength + 1 : Length - TimeLength
        
        for yc = BorderLength + 1 : height - BorderLength
            
            for xc = BorderLength + 1 : width - BorderLength
                
                CenterVal = VolData(yc, xc, i);
                %% In XY plane
                BasicLBP = 0;
                FeaBin = 0;
                
                for p = 0 : XYNeighborPoints - 1
                    X = floor(xc + FxRadius * cos((2 * pi * p) / XYNeighborPoints) + 0.5);
                    Y = floor(yc - FyRadius * sin((2 * pi * p) / XYNeighborPoints) + 0.5);
                    
                    CurrentVal = VolData(Y, X, i);
                    
                    if CurrentVal >= CenterVal
                        BasicLBP = BasicLBP + 2 ^ FeaBin;
                    end
                    FeaBin = FeaBin + 1;
                end
                %% if Bincount is "0", it means basic LBP-TOP will be
                %% computed and uniform patterns does not work in this case
                %%. Otherwide it should be the number of the uniform
                %%patterns, then "Code" keeps the lookup-table of the basic
                %%LBP and uniform LBP
                if Bincount == 0
                    Histogram(1, BasicLBP + 1) = Histogram(1, BasicLBP + 1) + 1;
                else
                    Histogram(1, Code(BasicLBP + 1, 2) + 1) = Histogram(1, Code(BasicLBP + 1, 2) + 1) + 1;
                end
                
                %% In XT plane
                BasicLBP = 0;
                FeaBin = 0;
                for p = 0 : XTNeighborPoints - 1
                    X = floor(xc + FxRadius * cos((2 * pi * p) / XTNeighborPoints) + 0.5);
                    Z = floor(i + TInterval * sin((2 * pi * p) / XTNeighborPoints) + 0.5);
                    
                    CurrentVal = VolData(yc, X, Z);
                    
                    if CurrentVal >= CenterVal
                        BasicLBP = BasicLBP + 2 ^ FeaBin;
                    end
                    FeaBin = FeaBin + 1;
                end
                
                %% if Bincount is "0", it means basic LBP-TOP will be
                %% computed and uniform patterns does not work in this case
                %%. Otherwide it should be the number of the uniform
                %%patterns, then "Code" keeps the lookup-table of the basic
                %%LBP and uniform LBP
                if Bincount == 0
                    Histogram(2, BasicLBP + 1) = Histogram(2, BasicLBP + 1) + 1;
                else % uniform patterns
                    Histogram(2, Code(BasicLBP + 1, 2) + 1) = Histogram(2, Code(BasicLBP + 1, 2) + 1) + 1;
                end
                
                %% In YT plane
                BasicLBP = 0;
                FeaBin = 0;
                for p = 0 : YTNeighborPoints - 1
                    Y = floor(yc - FyRadius * sin((2 * pi * p) / YTNeighborPoints) + 0.5);
                    Z = floor(i + TInterval * cos((2 * pi * p) / YTNeighborPoints) + 0.5);
                    
                    CurrentVal = VolData(Y, xc, Z);
                    
                    if CurrentVal >= CenterVal
                        BasicLBP = BasicLBP + 2 ^ FeaBin;
                    end
                    FeaBin = FeaBin + 1;
                end
                %% if Bincount is "0", it means basic LBP-TOP will be
                %% computed and uniform patterns does not work in this case
                %%. Otherwide it should be the number of the uniform
                %%patterns, then "Code" keeps the lookup-table of the basic
                %%LBP and uniform LBP
                if Bincount == 0
                    Histogram(3, BasicLBP + 1) = Histogram(3, BasicLBP + 1) + 1;
                else
                    Histogram(3, Code(BasicLBP + 1, 2) + 1) = Histogram(3, Code(BasicLBP + 1, 2) + 1) + 1;
                end
                
            end
        end
    end
else % bilinear interpolation
    for i = TimeLength + 1 : Length - TimeLength
        
        for yc = BorderLength + 1 : height - BorderLength
            
            for xc = BorderLength + 1 : width - BorderLength
                
                CenterVal = VolData(yc, xc, i);
                %% In XY plane
                BasicLBP = 0;
                FeaBin = 0;
                for p = 0 : XYNeighborPoints - 1
                    
                    % bilinear interpolation
                    x1 = single(xc + FxRadius * cos((2 * pi * p) / XYNeighborPoints));%%"float" are called "single" in Matlab
                    y1 = single(yc - FyRadius * sin((2 * pi * p) / XYNeighborPoints));
                    
                    u = x1 - floor(x1);
                    v = y1 - floor(y1);
                    ltx = floor(x1);
                    lty = floor(y1);
                    lbx = floor(x1);
                    lby = ceil(y1);
                    rtx = ceil(x1);
                    rty = floor(y1);
                    rbx = ceil(x1);
                    rby = ceil(y1);
                    % the values of neighbors that do not fall exactly on
                    % pixels are estimated by bilinear interpolation of
                    % four corner points near to it.
                    CurrentVal = floor(VolData(lty, ltx, i) * (1 - u) * (1 - v) + VolData(lby, lbx, i) * (1 - u) * v + VolData(rty, rtx, i) * u * (1 - v) + VolData(rby, rbx, i) * u * v);
                    
                    if CurrentVal >= CenterVal
                        BasicLBP = BasicLBP + 2 ^ FeaBin;
                    end
                    FeaBin = FeaBin + 1;
                end
                %% if Bincount is "0", it means basic LBP-TOP will be
                %% computed and uniform patterns does not work in this case
                %%. Otherwide it should be the number of the uniform
                %%patterns, then "Code" keeps the lookup-table of the basic
                %%LBP and uniform LBP
                if Bincount == 0
                    Histogram(1, BasicLBP + 1) = Histogram(1, BasicLBP + 1) + 1;
                else
                    Histogram(1, Code(BasicLBP + 1, 2) + 1) = Histogram(1, Code(BasicLBP + 1, 2) + 1) + 1;
                end
                
                %% In XT plane
                BasicLBP = 0;
                FeaBin = 0;
                for p = 0 : XTNeighborPoints - 1
                    % bilinear interpolation
                    x1 = single(xc + FxRadius * cos((2 * pi * p) / XTNeighborPoints));
                    z1 = single(i + TInterval * sin((2 * pi * p) / XTNeighborPoints));
                    
                    u = x1 - floor(x1);
                    v = z1 - floor(z1);
                    ltx = floor(x1);
                    lty = floor(z1);
                    lbx = floor(x1);
                    lby = ceil(z1);
                    rtx = ceil(x1);
                    rty = floor(z1);
                    rbx = ceil(x1);
                    rby = ceil(z1);
                    % the values of neighbors that do not fall exactly on
                    % pixels are estimated by bilinear interpolation of
                    % four corner points near to it.
                    CurrentVal = floor(VolData(yc, ltx, lty) * (1 - u) * (1 - v) + VolData(yc, lbx, lby) * (1 - u) * v + VolData(yc, rtx, rty) * u * (1 - v) + VolData(yc, rbx, rby) * u * v);
                    
                    if CurrentVal >= CenterVal
                        BasicLBP = BasicLBP + 2 ^ FeaBin;
                    end
                    FeaBin = FeaBin + 1;
                end
                %% if Bincount is "0", it means basic LBP-TOP will be
                %% computed and uniform patterns does not work in this case
                %%. Otherwide it should be the number of the uniform
                %%patterns, then "Code" keeps the lookup-table of the basic
                %%LBP and uniform LBP
                if Bincount == 0
                    Histogram(2, BasicLBP + 1) = Histogram(2, BasicLBP + 1) + 1;
                else
                    Histogram(2, Code(BasicLBP + 1, 2) + 1) = Histogram(2, Code(BasicLBP + 1, 2) + 1) + 1;
                end
                
                %% In YT plane
                BasicLBP = 0;
                FeaBin = 0;
                for p = 0 : YTNeighborPoints - 1
                    % bilinear interpolation
                    y1 = single(yc - FyRadius * sin((2 * pi * p) / YTNeighborPoints));
                    z1 = single(i + TInterval * cos((2 * pi * p) / YTNeighborPoints));
                    
                    u = y1 - floor(y1);
                    v = z1 - floor(z1);
                    ltx = floor(y1);
                    lty = floor(z1);
                    lbx = floor(y1);
                    lby = ceil(z1);
                    rtx = ceil(y1);
                    rty = floor(z1);
                    rbx = ceil(y1);
                    rby = ceil(z1);
                    % the values of neighbors that do not fall exactly on
                    % pixels are estimated by bilinear interpolation of
                    % four corner points near to it.
                    CurrentVal = floor(VolData(ltx, xc, lty) * (1 - u) * (1 - v) + VolData(lbx, xc, lby) * (1 - u) * v + VolData(rtx, xc, rty) * u * (1 - v) + VolData(rbx, xc, rby) * u * v);
                    
                    if CurrentVal >= CenterVal
                        BasicLBP = BasicLBP + 2 ^ FeaBin;
                    end
                    FeaBin = FeaBin + 1;
                end
                %% if Bincount is "0", it means basic LBP-TOP will be
                %% computed and uniform patterns does not work in this case
                %%. Otherwide it should be the number of the uniform
                %%patterns, then "Code" keeps the lookup-table of the basic
                %%LBP and uniform LBP
                if Bincount == 0
                    Histogram(3, BasicLBP + 1) = Histogram(3, BasicLBP + 1) + 1;
                else
                    Histogram(3, Code(BasicLBP + 1, 2) + 1) = Histogram(3, Code(BasicLBP + 1, 2) + 1) + 1;
                end
            end %% 
        end %%
    end %%
end

%% normalization
for j = 1 : 3
    Histogram(j, :) = Histogram(j, :)./sum(Histogram(j, :));
end