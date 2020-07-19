function PaintSURF(I, ipts)
% This function PaintSURF will display the image with the found  Interest points
%
% [] = PaintSURF( img,ipts )
%  
%  inputs,
%    img : Image 2D color or greyscale
%    ipts : The interest points
%  
% Function is written by D.Kroon University of Twente (July 2010)

% Convert Image to double
switch(class(I));
    case 'uint8'
        I=double(I)/255;
    case 'uint16'
        I=double(I)/65535;
    case 'int8'
        I=(double(I)+128)/255;
    case 'int16'
        I=(double(I)+32768)/65535;
    otherwise
        I=double(I);
end

figure, imshow(I), hold on;
if (isempty(fields(ipts))), return; end
for i=1:length(ipts)
   ip=ipts(i);
   
   S = 2 * fix(2.5 * ip.scale);
   R = fix(S / 2);

   pt =  [(ip.x), (ip.y)];
   ptR = [(R * cos(ip.orientation)), (R * sin(ip.orientation))];

   if(ip.laplacian >0), myPen =[0 0 1]; else myPen =[1 0 0]; end
   
   rectangle('Curvature', [1 1],'Position', [pt(1)-R, pt(2)-R, S, S],'EdgeColor',myPen);
   
    plot([pt(1), pt(1)+ptR(1)]+1,[pt(2), pt(2)+ptR(2)]+1,'g');
end