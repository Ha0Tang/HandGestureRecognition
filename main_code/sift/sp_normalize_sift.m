function [sift_arr, siftlen] = sp_normalize_sift(sift_arr, threshold)
% normalize SIFT descriptors (after Lowe)
%
% find indices of descriptors to be normalized (those whose norm is larger than 1)
siftlen = sqrt(sum(sift_arr.^2, 2));

normalize_ind1 = [siftlen >= threshold];
normalize_ind2 = ~normalize_ind1;

sift_arr_hcontrast = sift_arr(normalize_ind1, :);
sift_arr_hcontrast = sift_arr_hcontrast ./ repmat(siftlen(normalize_ind1, :), [1 size(sift_arr,2)]);

sift_arr_lcontrast = sift_arr(normalize_ind2,:);
sift_arr_lcontrast = sift_arr_lcontrast./ threshold;

% suppress large gradients
sift_arr_hcontrast( sift_arr_hcontrast > 0.2 ) = 0.2;
sift_arr_lcontrast( sift_arr_lcontrast > 0.2 ) = 0.2;

% finally, renormalize to unit length
sift_arr_hcontrast = sift_arr_hcontrast ./ repmat(sqrt(sum(sift_arr_hcontrast.^2, 2)), [1 size(sift_arr,2)]);

sift_arr(normalize_ind1,:) = sift_arr_hcontrast;
sift_arr(normalize_ind2,:) = sift_arr_lcontrast;