function [rows, cols] = brom_gen_32(infile, coeR, coeP, coeQ, numrows, numcols)

a = zeros(65536,1);
b = zeros(65536,1);
cc = zeros(65536,1);
img = rgb2gray(imread(infile));


imgresized = imresize(img, [numrows numcols]);

[rows, cols, rgb] = size(imgresized);

imgscaled = imgresized/16 - 1;
imshow(imgscaled*16);

count = 0;
for r = 1:rows-2
    for c = 1:cols		
		a(((r-1)*256+c),1) = uint8(imgresized(r,c));
        count = count + 1;
    end
end

count = 0;
for r = 2:rows-1
    for c = 1:cols		
		b(((r-2)*256+c),1) = uint8(imgresized(r,c));
        count = count + 1;
    end
end

count = 0;
for r = 3:rows
    for c = 1:cols		
		cc(((r-3)*256+c),1) = uint8(imgresized(r,c));
        count = count + 1;
    end
end

fid7 = fopen(coeR,'w');
fprintf(fid7,'MEMORY_INITIALIZATION_RADIX=16;\n');
fprintf(fid7,'MEMORY_INITIALIZATION_VECTOR=\n\n');
count = 0;
number = 1;
for r = 1:16256		
		r3=a(number+3,1);
		r2=a(number+2,1);
		r1=a(number+1,1);
		r0=a(number,1);
        fprintf(fid7,'%02x%02x%02x%02x,\n',r3,r2,r1,r0);
        count = count+1;
		number=number+4;
end
fclose(fid7);

fid8 = fopen(coeP,'w');
fprintf(fid8,'MEMORY_INITIALIZATION_RADIX=16;\n');
fprintf(fid8,'MEMORY_INITIALIZATION_VECTOR=\n\n');
count = 0;
number = 1;
for r = 1:16256		
		r3=b(number+3,1);
		r2=b(number+2,1);
		r1=b(number+1,1);
		r0=b(number,1);
        fprintf(fid8,'%02x%02x%02x%02x,\n',r3,r2,r1,r0);
        count = count+1;
		number=number+4;
end
fclose(fid8);

fid9 = fopen(coeQ,'w');
fprintf(fid9,'MEMORY_INITIALIZATION_RADIX=16;\n');
fprintf(fid9,'MEMORY_INITIALIZATION_VECTOR=\n\n');
count = 0;
number = 1;
for r = 1:16256		
		r3=cc(number+3,1);
		r2=cc(number+2,1);
		r1=cc(number+1,1);
		r0=cc(number,1);
        fprintf(fid9,'%02x%02x%02x%02x,\n',r3,r2,r1,r0);
        count = count+1;
		number=number+4;
end
fclose(fid9);
