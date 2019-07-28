function [key_frames_label] = cluster_dp( point )
% disp('The only input needed is a distance matrix file')
% disp('The format of this file should be: ')
% disp('Column 1: id of element i')
% disp('Column 2: id of element j')
% disp('Column 3: dist(i,j)')
keyframe =5;

pointNUM = length(point(:,1));
if pointNUM == 2
    dif=(max(point(:,1))-min(point(:,1)));
    key_frames_label = [point(:,1) ; round(dif/4+1);round(2*dif/4+1);round(3*dif/4+1)];
    key_frames_label =sort(key_frames_label); 
    assert(length(key_frames_label) ==5, 'There is a error, key_frames_labels ~ = 5');
elseif pointNUM == 3
    dif32=(max(point(3,1))-min(point(2,1)));
    dif21=(max(point(2,1))-min(point(1,1)));
    if dif32 >= dif21
        key_frames_label = [point(:,1) ; round(dif32/3+point(2,1)); round(2*dif32/3+point(2,1))];
    elseif dif32 < dif21
        key_frames_label = [point(:,1) ; round(dif21/3+point(1,1)); round(2*dif21/3+point(1,1))];
    end
    key_frames_label =sort(key_frames_label);
    assert(length(key_frames_label) ==5, 'There is a error, key_frames_labels ~ = 5');
elseif pointNUM == 4
    if  point(2,1) + 1 ~= point(3,1)
        key_frames_label = [point(:,1) ; round((point(3,1)+point(2,1))/2)];
    elseif point(2,1) + 1 == point(3,1)
        if point(3,1)< (point(4,1)+point(1,1))/2
           key_frames_label = [point(:,1) ; round((point(3,1)+point(4,1))/2)];
        elseif point(2,1)>= (point(4,1)+point(1,1))/2
           key_frames_label = [point(:,1) ; round((point(1,1)+point(2,1))/2)];
        end
    end
        key_frames_label =sort(key_frames_label);
        assert(length(key_frames_label) ==5, 'There is a error, key_frames_labels ~ = 5');
elseif pointNUM == keyframe
    key_frames_label = point(:,1);
else

    data = nchoosek(1:pointNUM,2);
    dataNUM = length(data(:,1));
    data(:,3)= pdist(point);
    
    xx = data;
    ND=max(xx(:,2));
    NL=max(xx(:,1));
    if (NL>ND)
      ND=NL; 
    end
    N=size(xx,1);
    for i=1:ND
      for j=1:ND
        dist(i,j)=0;
      end
    end

    for i=1:N
      ii=xx(i,1);
      jj=xx(i,2);
      dist(ii,jj)=xx(i,3);
      dist(jj,ii)=xx(i,3);
    end

    percent=2.0;
    fprintf('average percentage of neighbours (hard coded): %5.6f\n', percent);

    position=round(N*percent/10); 
    sda=sort(xx(:,3));
    dc=sda(position);

    fprintf('Computing Rho with gaussian kernel of radius: %12.6f\n', dc);

    for i=1:ND
      rho(i)=0.;
    end
    %
    % Gaussian kernel
    %
    for i=1:ND-1
      for j=i+1:ND
         rho(i)=rho(i)+exp(-(dist(i,j)/dc)*(dist(i,j)/dc));
         rho(j)=rho(j)+exp(-(dist(i,j)/dc)*(dist(i,j)/dc));
      end
    end

    %
    % "Cut off" kernel
    %
%     for i=1:ND-1
%      for j=i+1:ND
%        if (dist(i,j)<dc)
%           rho(i)=rho(i)+1.;
%           rho(j)=rho(j)+1.;
%        end
%      end
%     end


    maxd=max(max(dist));
    [rho_sorted,ordrho]=sort(rho,'descend');
    delta(ordrho(1))=-1.;
    nneigh(ordrho(1))=0;
    for ii=2:ND
       delta(ordrho(ii))=maxd;
       for jj=1:ii-1
         if(dist(ordrho(ii),ordrho(jj))<delta(ordrho(ii)))
            delta(ordrho(ii))=dist(ordrho(ii),ordrho(jj));
            nneigh(ordrho(ii))=ordrho(jj);
         end
       end
    end

    delta(ordrho(1))=max(delta(:));
    disp('Generated file:DECISION GRAPH')
    disp('column 1:Density')
    disp('column 2:Delta')

    fid = fopen('DECISION_GRAPH', 'w');
    for i=1:ND
       fprintf(fid, '%6.2f %6.2f\n', rho(i),delta(i));
    end
    scrsz = get(0,'ScreenSize');

    for i=1:ND
      ind(i)=i;
      gamma(i)=rho(i)*delta(i);
    end
    
    rhomin=min(rho)-0.001;

    delta_unique=unique(delta);
    delta_sorted=sort(delta_unique, 'descend');
    deltamin=delta_sorted(keyframe);

    NCLUST=0;
    for i=1:ND
      cl(i)=-1;
    end
    for i=1:ND
      if ( (rho(i)>rhomin) && (delta(i)>deltamin))
         NCLUST=NCLUST+1;
         cl(i)=NCLUST;
         icl(NCLUST)=i; 
      end
    end
    fprintf('NUMBER OF CLUSTERS: %i \n', NCLUST);
    disp('Performing assignation')

    for i=1:ND
      if (cl(ordrho(i))==-1)
        cl(ordrho(i))=cl(nneigh(ordrho(i)));
      end
    end

    %halo
    for i=1:ND
      halo(i)=cl(i);
    end

    if (NCLUST>1)
      for i=1:NCLUST
        bord_rho(i)=0.;
      end

      for i=1:ND-1
        for j=i+1:ND
          if ((cl(i)~=cl(j))&& (dist(i,j)<=dc))
            rho_aver=(rho(i)+rho(j))/2.; 
            if (rho_aver>bord_rho(cl(i))) 
              bord_rho(cl(i))=rho_aver;
            end
            if (rho_aver>bord_rho(cl(j))) 
              bord_rho(cl(j))=rho_aver;
            end
          end
        end
      end

      for i=1:ND
        if (rho(i)<bord_rho(cl(i)))
          halo(i)=0;
        end
      end
    end

    for i=1:NCLUST
      nc=0; 
      nh=0; 
      for j=1:ND
        if (cl(j)==i) 
          nc=nc+1;
        end
        if (halo(j)==i) 
          nh=nh+1;
        end
      end
      fprintf('CLUSTER: %i CENTER: %i ELEMENTS: %i CORE: %i HALO: %i \n', i,icl(i),nc,nh,nc-nh);
    end
    key_frames_label = point(icl,1);
    assert(length(key_frames_label) ==5, 'There is a error, key_frames_labels ~ = 5');

    faa = fopen('CLUSTER_ASSIGNATION', 'w');
    disp('Generated file:CLUSTER_ASSIGNATION')
    disp('column 1:element id')
    disp('column 2:cluster assignation without halo control')
    disp('column 3:cluster assignation with halo control')
    for i=1:ND
       fprintf(faa, '%i %i %i\n',i,cl(i),halo(i));
    end
end

   assert(length(key_frames_label) ==5, 'There is a error, key_frames_labels ~ = 5');
