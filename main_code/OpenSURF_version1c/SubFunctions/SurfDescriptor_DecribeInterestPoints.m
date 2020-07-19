function ipts = SurfDescriptor_DecribeInterestPoints(ipts, upright, extended, img, verbose)
% This function SurfDescriptor_DecribeInterestPoints will ..
%
% [ipts] = SurfDescriptor_DecribeInterestPoints( ipts,upright,extended,img )
%  
%  inputs,
%    ipts : Interest Points (x,y,scale)
%    bUpright : If true not rotation invariant descriptor
%    bExtended :  If true make a 128 values descriptor
%    img : Integral image
%    verbose : If true show useful information
%  
%  outputs,
%    ipts :  Interest Points (x,y,orientation,descriptor)
%  
% Function is written by D.Kroon University of Twente (July 2010)
if (isempty(fields(ipts))), return; end

if(verbose), h_ang=figure; drawnow, set(h_ang,'name','Angles'); else h_ang=[]; end
if(verbose), h_des=figure; drawnow, set(h_des,'name','Aligned Descriptor XY'); end
   
for i=1:length(ipts)
   % Display only information about the first 40 points
   if(i>40), verbose=false; end
   
   ip=ipts(i);
   % determine descriptor size
   if (extended), ip.descriptorLength = 128; else ip.descriptorLength = 64; end

   % Get the orientation
   if(verbose), figure(h_ang), subplot(5,8,i), end
   ip.orientation=SurfDescriptor_GetOrientation(ip,img,verbose);

   % Extract SURF descriptor
   if(verbose), figure(h_des), subplot(10,4,i), end
   ip.descriptor=SurfDescriptor_GetDescriptor(ip, upright, extended, img,verbose);
   
   ipts(i).orientation=ip.orientation;
   ipts(i).descriptor=ip.descriptor;
end

if(~isempty(h_ang)), figure(h_ang), colormap(jet); end