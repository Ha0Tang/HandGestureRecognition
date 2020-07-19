function Histogram = RIVLBP(VolData, TInterval, FRadius, NeighborPoints, BorderLength, TimeLength, RotateIndex, bBilinearInterpolation)
%% Readme..
% This function is to compute the Basic VLBP and two kinds of rotation invariant VLBP features for a video sequence
% Reference:
% Guoying Zhao, Matti Pietikainen, "Dynamic texture recognition using local binary patterns
%  with an application to facial expressions," IEEE Transactions on Pattern Analysis and Machine
%  Intelligence, 2007, 29(6):915-928.
%
%  Guoying Zhao, Matti Pietikainen, "Dynamic texture recognition using volume local binary patterns,"
% In: Dynamical Vision, WDW 2005/2006 Proceedings, Lecture Notes in Computer Science 4358, 2006, 165-177.
%
%  Copyright 2009 by Guoying Zhao & Matti Pietikainen
%  Matlab version was Created by Xiaohua Huang
% If you have any problems, please feel to contact Guoying Zhao and Xiaohua Huang.
% huang.xiaohua@ee.oulu.fi
% Inputs:
% "VolData" keeps the grey level of all the pixels in sequences with [height][width][Length];
%      please note, all the images in one sequnces should have same size (height and weight).
%      But they don't have to be same for different sequences.
% "FRadius", and "TInterval" are the radii parameter in space and Time axis; They could be 1, 2 or 3 or 4.
% Pay attention to "TInterval". "TInterval * 2 + 1" should be smaller than
% the length of the input sequence "Length". For example, if one sequence includes seven frames, and you set TInterval to three, only the pixels in the frame 4 would be considered as central pixel and computed to get the LBP-TOP feature.
% "NeighborPoints" is the number of the neighboring points; It can be 2 and 4.
% Since this "NeighborPoints" means the number of the neighboring points in one frame and the number of all the neighboring points for computing VLBP is pow(2,(NeighborPoints + 1) * 2 + NeighborPoints),
% so this value could not be very big. 2 and 4 are good options.
% "TimeLength" and "BorderLength" are the parameters for bordering parts in time and
%      space which would not be computed for features. Usually they are same to TInterval and
%      FRadius;
% "RotateIndex": 0: basic VLBP without rotation;
%                1: new Rotation invariant descriptor published in PAMI 2007;
%                2: old Rotation invariant descriptor published in ECCV
%                workshop 2006
% "bBilinearInterpolation": if use bilinear interpolation for computing a neighboring point in a circle: 1 (yes), 0 (no).
% Output:
% "Histogram": LBP-TOP distribution. each value between [0,1]
%%
[height width Length] = size(VolData);
binCount = (NeighborPoints + 1) * 2 + NeighborPoints;
nDim = 2 ^ binCount;
Histogram = zeros(nDim, 1);

if bBilinearInterpolation == 0
    
    for i = TimeLength + 1 : Length - TimeLength
        
        for yc = BorderLength + 1 :  height - BorderLength
            
            for xc = BorderLength + 1 : width - BorderLength
                
                CenterVal = VolData(yc, xc, i);
                BasicLBP = 0;
                FeaBin = 0;
                
                %% In previous frame
                CurrentVal = VolData(yc, xc, i - TInterval);
                
                if CurrentVal >= CenterVal
                    BasicLBP = BasicLBP + 2 ^ FeaBin;
                end
                tempLBPpreC = BasicLBP;
                FeaBin = FeaBin + 1;
                
                tempLBPpre = 0;
                for p = 0 : NeighborPoints - 1
                    X = floor(xc + FRadius * cos((2 * pi * p) / NeighborPoints) + 0.5);
                    Y = floor(yc - FRadius * sin((2 * pi * p) / NeighborPoints) + 0.5);
                    
                    CurrentVal = VolData(Y, X, i - TInterval);
                    
                    if CurrentVal >= CenterVal
                        BasicLBP = BasicLBP + 2 ^ FeaBin;
                        tempLBPpre = tempLBPpre + 2 ^ p;
                    end
                    FeaBin = FeaBin + 1;
                end
                
                %% In current frame
                tempLBPcur = 0;
                for p = 0 : NeighborPoints - 1
                    X = floor(xc + FRadius * cos((2 * pi * p) / NeighborPoints) + 0.5);
                    Y = floor(yc - FRadius * sin((2 * pi * p) / NeighborPoints) + 0.5);
                    
                    CurrentVal = VolData(Y, X, i);
                    
                    if CurrentVal >= CenterVal
                        BasicLBP = BasicLBP + 2 ^ FeaBin;
                        tempLBPcur = tempLBPcur + 2 ^ p;
                    end
                    FeaBin = FeaBin + 1;
                end
                
                %% In post frame
                tempLBPpos = 0;
                for p = 0 : NeighborPoints - 1
                    X = floor(xc + FRadius * cos((2 * pi * p) / NeighborPoints) + 0.5);
                    Y = floor(yc - FRadius * sin((2 * pi * p) / NeighborPoints) + 0.5);
                    
                    CurrentVal = VolData(Y, X, i + TInterval);
                    
                    if CurrentVal >= CenterVal
                        BasicLBP = BasicLBP + 2 ^ FeaBin;
                        tempLBPpos = tempLBPpos + 2 ^ p;
                    end
                    FeaBin = FeaBin + 1;
                end
                
                tempLBPposC = 0;
                
                CurrentVal = VolData(yc, xc, i + TInterval);
                
                if CurrentVal >= CenterVal
                    BasicLBP = BasicLBP + 2 ^ FeaBin;
                    tempLBPposC = 1;
                end
                
                %% Rotation invariance (if RotateIndex = 1/2)
                if (RotateIndex == 1)||(RotateIndex == 2)
                    % if RotateIndex == 0, basic VLBP is computed
                    % else for rotation invariance code
                    BasicLBP = ComputeRotationInvariance(RotateIndex, NeighborPoints, tempLBPpre, tempLBPcur, tempLBPpos, tempLBPpreC, tempLBPposC, binCount, BasicLBP);
                end
                % the index under matlab start from 1 in the vector and matrix
                Histogram(BasicLBP + 1) = Histogram(BasicLBP + 1) + 1;
            end
        end
    end
else
    for i = TimeLength + 1: Length - TimeLength
        
        for yc = BorderLength + 1 :  height - BorderLength
            
            for xc = BorderLength + 1 : width - BorderLength
                
                CenterVal = VolData(yc, xc, i);
                
                BasicLBP = 0;
                FeaBin = 0;
                
                %% In previous frame
                CurrentVal = VolData(yc, xc, i - TInterval);
                
                if CurrentVal >= CenterVal
                    BasicLBP = BasicLBP + 2 ^ FeaBin;
                end
                
                tempLBPpreC = BasicLBP;
                FeaBin = FeaBin + 1;
                
                tempLBPpre = 0;
                
                for p = 0 : NeighborPoints - 1
                    % bilinear interpolation
                    x1 = single(xc + FRadius * cos((2 * pi * p)/NeighborPoints));
                    y1 = single(yc - FRadius * sin((2 * pi * p)/NeighborPoints));
                    
                    u = x1 - floor(x1);
                    v = y1 - floor(y1);
                    ltx = (floor(x1));
                    lty = (floor(y1));
                    lbx = (floor(x1));
                    lby = (ceil(y1));
                    rtx = (ceil(x1));
                    rty = (floor(y1));
                    rbx = (ceil(x1));
                    rby = (ceil(y1));
                    % values of neighbors that do not fall exactly on
                    % pixels are estimated by bilinear interpolation of
                    % four corner points near to it
                    CurrentVal = floor(VolData(lty, ltx, i - TInterval) * (1 - u) * (1 - v) + VolData(lby, lbx, i - TInterval) * (1 - u) * v + VolData(rty, rtx, i - TInterval) * u * (1 - v) + VolData(rby, rbx, i - TInterval) * u * v);
                    
                    if CurrentVal >= CenterVal
                        BasicLBP = BasicLBP + 2 ^ FeaBin;
                        tempLBPpre = tempLBPpre + 2 ^ p;
                    end
                    FeaBin = FeaBin + 1;
                end
                
                %% In current frame
                tempLBPcur = 0;
                for p = 0 : NeighborPoints - 1
                    % bilinear interpolation
                    x1 = single(xc + FRadius * cos((2 * pi * p)/NeighborPoints));
                    y1 = single(yc - FRadius * sin((2 * pi * p)/NeighborPoints));
                    
                    u = x1 - floor(x1);
                    v = y1 - floor(y1);
                    ltx = (floor(x1));
                    lty = (floor(y1));
                    lbx = (floor(x1));
                    lby = (ceil(y1));
                    rtx = (ceil(x1));
                    rty = (floor(y1));
                    rbx = (ceil(x1));
                    rby = (ceil(y1));
                    % values of neighbors that do not fall exactly on
                    % pixels are estimated by bilinear interpolation of
                    % four corner points near to it
                    CurrentVal = floor(VolData(lty, ltx, i) * (1 - u) * (1 - v) + VolData(lby, lbx, i) * (1 - u) * v + VolData(rty, rtx, i) * u * (1 - v) + VolData(rby, rbx, i) * u * v);
                    
                    if CurrentVal >= CenterVal
                        BasicLBP = BasicLBP + 2 ^ FeaBin;
                        tempLBPcur = tempLBPcur + 2 ^ p;
                    end
                    FeaBin = FeaBin + 1;
                end
                
                %% In post frame
                tempLBPpos = 0;
                
                for p = 0 : NeighborPoints - 1
                    % bilinear interpolation
                    x1 = single(xc + FRadius * cos((2 * pi * p)/NeighborPoints));
                    y1 = single(yc - FRadius * sin((2 * pi * p)/NeighborPoints));
                    
                    u = x1 - floor(x1);
                    v = y1 - floor(y1);
                    ltx = (floor(x1));
                    lty = (floor(y1));
                    lbx = (floor(x1));
                    lby = (ceil(y1));
                    rtx = (ceil(x1));
                    rty = (floor(y1));
                    rbx = (ceil(x1));
                    rby = (ceil(y1));
                    % values of neighbors that do not fall exactly on
                    % pixels are estimated by bilinear interpolation of
                    % four corner points near to it
                    CurrentVal = floor(VolData(lty, ltx, i + TInterval) * (1 - u) * (1 - v) + VolData(lby, lbx, i + TInterval) * (1 - u) * v + VolData(rty, rtx, i + TInterval) * u * (1 - v) + VolData(rby, rbx, i + TInterval) * u * v);
                    
                    if CurrentVal >= CenterVal
                        BasicLBP = BasicLBP + 2 ^ FeaBin;
                        tempLBPpos = tempLBPpos + 2 ^ p;
                    end
                    FeaBin  = FeaBin + 1;
                end
                
                tempLBPposC = 0;
                CurrentVal = VolData(yc, xc, i + TInterval);
                
                if (CurrentVal >= CenterVal)
                    BasicLBP = BasicLBP + 2 ^ FeaBin;
                    tempLBPposC = 1;
                end
                
                %% rotation invariance (if RotateIndex = 1/2)
                if (RotateIndex == 1) || (RotateIndex == 2)
                    %for roataion invariance code
                    BasicLBP = ComputeRotationInvariance(RotateIndex, NeighborPoints, tempLBPpre, tempLBPcur, tempLBPpos, tempLBPpreC, tempLBPposC, binCount, BasicLBP);
                end
                % the index under matlab start from 1 in the vector and
                % matrix
                Histogram(BasicLBP + 1) = Histogram(BasicLBP + 1) + 1;
            end
        end
    end
end

%% Normalization
Total = 0;
for i = 1 : nDim
    Total = Total + Histogram(i);
end
Histogram = Histogram./Total;




