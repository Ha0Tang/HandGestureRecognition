function h = hsvhist(rgb_img, bins)
clip = rgb2hsv(rgb_img);
z = size(clip,3);
clip2 = zeros(size(clip,1),size(clip,2));

f = 1;

for i = 1:z
   clip2 = clip2 + f*floor( clip(:,:,i) * bins(i) );
   f=f * bins(i);
end

h = hist(clip2(:), 0:(f-1));
end