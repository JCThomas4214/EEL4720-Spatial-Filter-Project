%Block RAM .coe File Generator
%Author: Jonathan Ganyer
%Warning: This file should only be used as a reference. This should be 
%used as a template to write your images into a .coe file. Your output 
%will vary depending on the output method you describe in your project 
%(RGB,grayscale, etc). The default program below takes an input image
%file (jpg, tiff, etc) and outputs the memory to a separate file (coe). 
%The four variables are as follows:
%infile: Input file you want to convert (input.jpg, input.tiff, etc)
%outfname: Output file you want (output.coe)
%numrows: Number of rows you want in the output image
%numcols: Number of columns you want in the output image.
%Here's an example of inputting an image (fence.jpg) and outputting to a
%coe file scaled to a resolution of 256x256:
% [outfname, rows, cols] = bram_gen_lam('fence.jpg', 'fence.coe',256,256)
function [outfname, rows, cols] = bram_gen_lam(infile, outfname, numrows, numcols)
img = imread(infile);
imgresized = imresize(img, [numrows numcols]);
[rows, cols, rgb] = size(imgresized);
imgscaled = imgresized/16 - 1;
imshow(imgscaled*16);
fid = fopen(outfname,'w');

%12-Bit RGB Palette Decimal Output File (Default)
fprintf(fid,'MEMORY_INITIALIZATION_RADIX=16;\n');
fprintf(fid,'MEMORY_INITIALIZATION_VECTOR=\n\n');

count = 0;
for r = 1:rows
    for c = 1:cols
        red = uint16(imgscaled(r,c,1));
        green = uint16(imgscaled(r,c,2));
        blue = uint16(imgscaled(r,c,3));
        color = red*(256) + green*16 + blue;
        fprintf(fid,'%4u', color);
        count = count + 1;
        if (c == cols) && (r == rows)
            fprintf(fid,';');
        else
            fprintf(fid,',\n');
        end
    end
end


fclose(fid);

