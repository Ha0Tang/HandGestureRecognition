function myhist = buildOriHists(x,y,z,radius,pix,fv)
LoadParams;

if (Display_flag ==1)
    figure;
    hold on;
    axis equal;
    for i=1:nFaces
        tmp(1,:) = fv.vertices(fv.faces(i,1),:);
        tmp(2,:) = fv.vertices(fv.faces(i,2),:);
        tmp(3,:) = fv.vertices(fv.faces(i,3),:);
        tmp(4,:) = fv.vertices(fv.faces(i,1),:);

        plot3(tmp(:,1),tmp(:,2),tmp(:,3),'r-')
        plot3(fv.centers(i,1),fv.centers(i,2),fv.centers(i,3),'bx')
    end
end


xi = int16(x);
yi = int16(y);
zi = int16(z);
[rows cols slices] = size(pix);
myhist = zeros(1,nFaces);


for r = xi - radius:xi + radius
    for c = yi - radius:yi + radius
        for s = zi - radius:zi + radius
            %          /* Do not use last row or column, which are not valid. */
            if (r >= 1 && c >= 1 && r < rows - 1 && c < cols - 1 && s >= 1 && s < slices - 1)
                [mag vect] = GetGradOri_vector(pix,r,c,s);
                
                corr_array = fv.centers * vect';

                [yy ix] = sort(corr_array,'descend');
                
                if (Display_flag ==1)
                    plot3(vect(1),vect(2),vect(3),'k.')
                    plot3(fv.centers(ix(1),1),fv.centers(ix(1),2),fv.centers(ix(1),3),'b*')
                end
                
                myhist(ix(1)) = myhist(ix(1)) + mag;
            end
        end
    end
end

clear tmp;

if (Display_flag == 1)
    for i=1:nFaces
        tmp(1,:) = [0 0 0];
        tmp(2,:) = (myhist(i) / max(myhist)) .* fv.centers(i,:);
        
        plot3(tmp(:,1),tmp(:,2),tmp(:,3),'g-','LineWidth',2)
    end
end
