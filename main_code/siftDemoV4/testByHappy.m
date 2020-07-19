clear all; clc;
[image1,descriptors1,locs1] = sift('v1.jpg');
[image2,descriptors2,locs2] = sift('v2.jpg') ;
showkeys(image1, locs1);
showkeys(image2, locs2);
matches = siftmatch(descriptors1, descriptors2) ;

plotsiftmatches(I1,I2,iamge1,frames2,matches);