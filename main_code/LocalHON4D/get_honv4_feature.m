function HONV_feauture = get_honv4_feature(frame_count,dx_img,dy_img,dz_img,center_x, center_y, ...
    center_z, cell,P)

% Note: this code is not optimized, and can be easily made faster

DIM = cell.DIM;
xStep = cell.width/cell.numR;
yStep = cell.height/cell.numC;
tStep = cell.depth/cell.numD;

nPointx =center_x - ((cell.numR-1)/2)*xStep - .5*xStep;
nPointy =center_y - ((cell.numC-1)/2)*yStep - .5*yStep;
nPointt =frame_count - ((cell.numD-1)/2)*tStep - .5*tStep;

HONV_feauture = [];
for ct=0:cell.numD-1
    for ci=0:cell.numR-1
        for cj=0:cell.numC-1
            
            xmin = nPointx + xStep * ci;
            ymin = nPointy + yStep * cj;
            xmax = xmin + xStep -1;
            ymax = ymin + yStep -1;
            
            ymax = max(min(ymax,size(dx_img,1)),1);
            xmax = max(min(xmax,size(dx_img,2)),1);
            
            ymin = max(ymin,1);
            xmin = max(xmin,1);
            
            tmin = nPointt + tStep*ct;
            tmax = tmin + tStep-1;
            
            gx_c = dx_img([ymin:ymax],[xmin:xmax],[tmin:tmax]);
            gy_c = dy_img([ymin:ymax],[xmin:xmax],[tmin:tmax]);
            gz_c = dz_img([ymin:ymax],[xmin:xmax],[tmin:tmax]);
            
            gx_c = gx_c(:);
            gy_c = gy_c(:);
            gz_c = gz_c(:);
            
            validInd = intersect(intersect(find(gx_c~=0),find(gy_c~=0)),find(gz_c~=0));
            
            gx_c = gx_c(validInd);
            gy_c = gy_c(validInd);
            gz_c = gz_c(validInd);
            
            
            
            gmags = sqrt(gx_c.^2 + gy_c.^2 + gz_c.^2);
            gmags_rep = repmat(gmags,1,DIM);
            
            gmat = [gx_c,gy_c,gz_c,-1*ones(length(gx_c),1)];
            
            
            
            
            res = (P*gmat')';
            
            res_norm = res./gmags_rep;
            
            res_norm(isinf(res_norm)) = 0;
            res_norm(isnan(res_norm)) = 0;
            
            
            res_norm = res_norm - 1.3090;
            res_norm(res_norm<0) = 0;
            
            
            vecmag = sqrt(sum(res_norm.^2,2));
            vecmag_rep = repmat(vecmag,1,DIM);
            
            
            res_norm = res_norm./vecmag_rep;
            res_norm(isinf(res_norm)) = 0;
            res_norm(isnan(res_norm)) = 0;
            
            
            res_norm = res_norm./length(validInd);
              
            HONV_feauture = [HONV_feauture,sum(res_norm,1)];
        end
    end
end