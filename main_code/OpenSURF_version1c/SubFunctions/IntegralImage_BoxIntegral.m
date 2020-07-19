function an=IntegralImage_BoxIntegral(row, col, rows,cols,img)

% Get integer coordinates
row=fix(row);
col=fix(col);
rows=fix(rows);
cols=fix(cols);

% Get the corner coordinates of the box integral
r1 = min(row, size(img,1));
c1 = min(col, size(img,2));
r2 = min(row + rows, size(img,1));
c2 = min(col + cols, size(img,2));

% Get the values at the cornes of the box integral (fast 1D index look up)
sx=size(img,1);
A = img(max(r1+(c1-1)*sx,1));
B = img(max(r1+(c2-1)*sx,1));
C = img(max(r2+(c1-1)*sx,1));
D = img(max(r2+(c2-1)*sx,1));

% If coordinates are outside at the top or left, the value must be zero
A((r1<1)|(c1<1))=0;
B((r1<1)|(c2<1))=0;
C((r2<1)|(c1<1))=0;
D((r2<1)|(c2<1))=0;

% Minimum value of the integral is zero
an=max(0, A - B - C + D);


