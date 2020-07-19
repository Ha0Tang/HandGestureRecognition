function [ res ] = absdif( I,J )
        k=rgb2gray(I);
        l=rgb2gray(J);
        m=imhist(k);
        n=imhist(l);
        dif=imabsdiff(m,n);
        res=sum(dif);
end