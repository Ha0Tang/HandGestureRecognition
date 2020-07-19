function P =loadProjector(pfile,sz)
fid=fopen(pfile,'r');
tline = fgets(fid);
P = [];
for i=1:sz
    tline = fgets(fid);
    line =textscan(tline, '%f', 'delimiter', ',');
    P(i,:) = line{1}';
end
fclose(fid);