function ipts=FastHessian_getIpoints(FastHessianData,verbose)
% filter index map

filter_map = [0,1,2,3;
    1,3,4,5;
    3,5,6,7;
    5,7,8,9;
    7,9,10,11]+1;

np=0; ipts=struct;

% Build the response map
responseMap=FastHessian_buildResponseMap(FastHessianData);

% Find the maxima acrros scale and space
for o = 1:FastHessianData.octaves
    for i = 1:2
        b = responseMap{filter_map(o,i)};
        m = responseMap{filter_map(o,i+1)};
        t = responseMap{filter_map(o,i+2)};
        
        % loop over middle response layer at density of the most
        % sparse layer (always top), to find maxima across scale and space
        [c,r]=ndgrid(0:t.width-1,0:t.height-1);
        r=r(:); c=c(:);
        
        p=find(FastHessian_isExtremum(r, c, t, m, b,FastHessianData));
        for j=1:length(p);
            ind=p(j);
            [ipts,np]=FastHessian_interpolateExtremum(r(ind), c(ind), t, m, b, ipts,np);
        end
    end
end

% Show laplacian and response maps with found interest-points
if(verbose)
    % Show the response map
    if(verbose)
        fig_h=ceil(length(responseMap)/3);
        h=figure;  set(h,'name','Laplacian');
        for i=1:length(responseMap), 
            pic=reshape(responseMap{i}.laplacian,[responseMap{i}.width responseMap{i}.height]);
            subplot(3,fig_h,i); imshow(pic,[]); hold on;
        end
        h=figure; set(h,'name','Responses');
        h_res=zeros(1,length(responseMap));
        for i=1:length(responseMap), 
            pic=reshape(responseMap{i}.responses,[responseMap{i}.width responseMap{i}.height]);
            h_res(i)=subplot(3,fig_h,i); imshow(pic,[]); hold on;
        end
    end
    
    % Show the maximum points
    disp(['Number of interest points found ' num2str(np)]);
    scales=zeros(1,length(responseMap));
    scaley=zeros(1,length(responseMap));
    scalex=zeros(1,length(responseMap));
    for i=1:length(responseMap)
        scales(i)=responseMap{i}.filter*(2/15);
        scalex(i)=responseMap{i}.width/size(FastHessianData.img,2);
        scaley(i)=responseMap{i}.height/size(FastHessianData.img,1);
    end
    for i=1:np
        [t,ind]=min((scales-ipts(i).scale).^2);
        plot(h_res(ind),ipts(i).y*scaley(ind)+1,ipts(i).x*scalex(ind)+1,'o','color',rand(1,3));
    end
end
