function [keypoint reRun] = Create_Descriptor(pix, xyScale, tScale, x, y, z)
% Main function of 3DSIFT Program from http://www.cs.ucf.edu/~pscovann/
% 
% Inputs:
% pix - a 3 dimensional matrix of uint8
% xyScale and tScale - affects both the scale and the resolution, these are
% usually set to 1 and scaling is done before calling this function
% x, y, and z - the location of the center of the keypoint where a descriptor is requested
%
% Outputs:
% keypoint - the descriptor, varies in size depending on values in LoadParams.m
% reRun - a flag (0 or 1) which is set if the data at (x,y,z) is not
% descriptive enough for a good keypoint
%
% Example:
% See Demo.m


LoadParams;

reRun = 0;

radius = int16(xyScale * 3.0);

fv = sphere_tri('ico',Tessellation_levels,1);
myhist = buildOriHists(x,y,z,radius,pix,fv);

[yy ix] = sort(myhist,'descend');
% Dom_Peak = ix(1);
% Sec_Peak = ix(2);
    
if (TwoPeak_Flag == 1 && dot(fv.centers(ix(1),:),fv.centers(ix(2),:)) > .9 && dot(fv.centers(ix(1),:),fv.centers(ix(3),:)) > .9)
    disp('MISS : Top 3 orientations within ~25 degree range : Returning with reRun flag set.');
    keypoint = 0;
    reRun = 1;
    return;
end

keypoint = MakeKeypoint(pix, xyScale, tScale, x, y, z);

