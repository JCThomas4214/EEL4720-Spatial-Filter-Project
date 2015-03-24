function [data] = bramread(infile)


fid = fopen(infile);
data = dlmread(infile);
k = mat2gray(data,[255,0]);
imshow(k);
fprintf(fid,'END;');
fclose(fid);
