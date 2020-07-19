function BasicLBP = ComputeRotationInvariance(RotateIndex, NeighborPoints, tempLBPpre, tempLBPcur, tempLBPpos, tempLBPpreC, tempLBPposC, binCount, BasicLBP)
%% readme
% for rotation invariance code
% Please note, the length of rotaion invariant VLBP is shorter than basic VLBP. 
% For example, for "NeighborPoints = 4", the length of basic VLBP is 16384, 
% while the length of new rotation invariant VLBP is 4176 and old rotation invariant VLBP 864.
% But in the following code, we keeps the length of histogram same to basic VLBP. 
%Just the values of some VLBP are computed into their rotation invariant value and then original bits in histogram are zero.
% It is mainly to show how to compute the rotation invariant VLBP.
% You can make some postprocessing afterwards. Or you can make a lookup table 
%according to the codes below to make the processing faster, like the uniform pattern we use in the LBP-TOP above.
%  Copyright 2009 by Guoying Zhao & Matti Pietikainen
%  Matlab verion was Created by Xiaohua Huang
% If you have any problems, please feel to contact Guoying Zhao and Xiaohua Huang.
% huang.xiaohua@ee.oulu.fi
%%
minLBP = BasicLBP;
if RotateIndex == 1
    for p = 1 : NeighborPoints - 1
        tempLBPpreT = bitor(bitshift(tempLBPpre, -1 * p), bitshift(bitand(tempLBPpre, (uint8(2^p) - 1)), (NeighborPoints - p)));
        tempLBPcurT = bitor(bitshift(tempLBPcur, -1 * p), bitshift(bitand(tempLBPcur, (uint8(2^p) - 1)), (NeighborPoints - p)));
        tempLBPposT = bitor(bitshift(tempLBPpos, -1 * p), bitshift(bitand(tempLBPpos, (uint8(2^p) - 1)), (NeighborPoints - p)));
        
        temp = (tempLBPpreC + bitshift(double(tempLBPpreT), 1)) + bitshift(double(tempLBPcurT), (NeighborPoints + 1)) + bitshift(double(tempLBPposT), (NeighborPoints * 2 + 1)) + tempLBPposC * 2 ^ (binCount - 1);
        
        if temp < minLBP
            minLBP = temp;
        end
    end
    BasicLBP = minLBP;
else
    %% old rotation invariant descritpor which is published in Dynamic
    %% Vision, WDW 2005/2006 Proceedings 2006
    tempLBPpreT = RotLBP(tempLBPpre, NeighborPoints);
    tempLBPcurT = RotLBP(tempLBPcur, NeighborPoints);
    tempLBPposT = RotLBP(tempLBPpos, NeighborPoints);
    
    temp = tempLBPpreC + bitshift(double(tempLBPpreT), 1) + bitshift(double(tempLBPcurT), (NeighborPoints + 1)) + bitshift(double(tempLBPposT), (NeighborPoints * 2 + 1)) + tempLBPposC * 2 ^ (binCount - 1);
    
    BasicLBP = temp;
end
