function index = PlaceInIndex(index, mag, vect, i, j, s, fv)

LoadParams;

corr_array = fv.centers * vect';

[yy ix] = sort(corr_array,'descend');

if (Smooth_Flag == 0)
    index(i,j,s,ix(1)) = index(i,j,s,ix(1)) + mag;
elseif (Smooth_Flag == 1)
    tmpsum = sum(yy(1:3).^Smooth_Var);
    for ii=1:3
        index(i,j,s,ix(ii)) = index(i,j,s,ix(ii)) + ( mag * ( yy(ii) .^ Smooth_Var ) / tmpsum );
    end
end
