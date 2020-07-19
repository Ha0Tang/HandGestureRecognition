function hist = extract_hsv(img_path)
% given the path of an image, extract hsv histogram as global feature

bins = [20, 10, 5]; % 1000-dim HSV histogram
img = double(imread(img_path))./255; 
hist = hsvhist(img, bins);