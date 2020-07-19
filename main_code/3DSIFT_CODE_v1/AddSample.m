function index = AddSample(index, k, pix, distsq, r, c, s, i_indx, j_indx, s_indx, fv)

LoadParams;

if (r < 1  ||  r > size(pix,1)  ||  c < 1  ||  c > size(pix,2) || s < 1 || s > size(pix,3))
    return;
end

sigma = IndexSigma * 0.5 * IndexSize;
weight = exp(-double(distsq / (2.0 * sigma * sigma)));

[grad vect] = GetGradOri_vector(pix,r,c,s);
mag = weight * grad;

index = PlaceInIndex(index, mag, vect, i_indx, j_indx, s_indx, fv);

end
 
