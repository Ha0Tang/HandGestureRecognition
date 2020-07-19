function vec = KeySampleVec(key, pix)
LoadParams;


% Method 1
index = KeySample(key, pix);
vec = index(:);

% % Method 2
% index = KeySample2D(key, grad, ori, scale, row, col);
% vec = index(:);

% % Method 3
% n = 0;
% orig_frame = key.frame;
% for t_offset=-4:4
%     key.frame = orig_frame + t_offset;
%     index = KeySample2D(key, grad, ori, scale, row, col);
%     vec_temp = index(:);
%     n = n + 1;
%     vec((n-1)*length(vec_temp)+1:n*length(vec_temp)) = vec_temp;
% end
% key.frame = orig_frame;
% vec = vec';

% % Method 4
% index = KeySample2D(key, grad, ori, scale, row, col);
% index = KeySample2Dxt(key, grad, ori, scale, row, col);
% index = KeySample2Dyt(key, grad, ori, scale, row, col);


end
