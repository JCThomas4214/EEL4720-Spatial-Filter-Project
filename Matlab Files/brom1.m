function [outfname, rows, cols] = brom1(infile, outfname, numrows, numcols)

img = imread(infile);

imgresized = imresize(img, [numrows numcols]);

[rows, cols, rgb] = size(imgresized);

imgscaled = imgresized/16 - 1;
imshow(imgscaled*16);

fid = fopen(outfname,'w');

fprintf(fid,'-- %3ux%3u Grey Scale Image\n\n',rows,cols);
fprintf(fid,'WIDTH = 8;\n');
fprintf(fid,'DEPTH = %4u;\n\n',(rows-2)*cols);
fprintf(fid,'ADDRESS_RADIX = UNS;\n');
fprintf(fid,'DATA_RADIX = UNS;\n\n');
fprintf(fid,'CONTENT BEGIN\n');

count = 0;
for r = 1:rows-2
    for c = 1:cols
        red = uint16(imgscaled(r,c,1));
        green = uint16(imgscaled(r,c,2));
        blue = uint16(imgscaled(r,c,3));
		grey1 = uint8(imgscaled(r,c,2));
		grey0 = uint8(imgscaled(r,c,1));
        color = red*(256) + green*16 + blue;
		grey = grey1*16 + grey0;
        fprintf(fid,'%4u : %4u;\n',count, grey);
        count = count + 1;
    end
end
fprintf(fid,'END;');
fclose(fid);
