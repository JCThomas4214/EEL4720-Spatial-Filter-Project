function [rows, cols, imgresized2] = h_gen_32(infile, coeR, coeP, coeQ, numrows, numcols)

a = zeros(65538,1);
b = zeros(65538,1);
cc = zeros(65538,1);
img = rgb2gray(imread(infile));


imgresized = imresize(img, [numrows numcols]);
imgresized2 = uint8(imgresized);
[rows, cols, rgb] = size(imgresized);

imgscaled = imgresized/16 - 1;
imshow(imgscaled*16);

%fid = fopen(outfname,'w');

% fprintf(fid,'-- %3ux%3u Grey Scale Image\n\n',rows,cols);
% fprintf(fid,'WIDTH = 72;\n');
% fprintf(fid,'DEPTH = %4u;\n\n',((rows-2)*cols))/9;
% fprintf(fid,'ADDRESS_RADIX = HEX;\n');
% fprintf(fid,'DATA_RADIX = HEX;\n\n');
% fprintf(fid,'CONTENT BEGIN\n');

count = 0;
for r = 1:rows-2
    for c = 1:cols
		grey = 	uint8(imgresized(r,c));
		a(((r-1)*256+c),1) = uint8(imgresized(r,c));
%         fprintf(fid,'% : %4u;\n',count, grey);
        count = count + 1;
    end
end
% fprintf(fid,'END;');
% fclose(fid);

% fid2 = fopen(outfname2,'w');
% 
% fprintf(fid2,'-- %3ux%3u Grey Scale Image\n\n',rows,cols);
% fprintf(fid2,'WIDTH = 8;\n');
% fprintf(fid2,'DEPTH = %4u;\n\n',(rows-2)*cols);
% fprintf(fid2,'ADDRESS_RADIX = HEX;\n');
% fprintf(fid2,'DATA_RADIX = HEX;\n\n');
% fprintf(fid2,'CONTENT BEGIN\n');

count = 0;
for r = 2:rows-1
    for c = 1:cols
		grey = 	uint8(imgresized(r,c));
		b(((r-2)*256+c),1) = uint8(imgresized(r,c));
%         fprintf(fid2,'%4u : %4u;\n',count, grey);
        count = count + 1;
    end
end
% fprintf(fid2,'END;');
% fclose(fid2);


% fid3 = fopen(outfname3,'w');
% 
% fprintf(fid3,'-- %3ux%3u Grey Scale Image\n\n',rows,cols);
% fprintf(fid3,'WIDTH = 8;\n');
% fprintf(fid3,'DEPTH = %4u;\n\n',(rows-2)*cols);
% fprintf(fid3,'ADDRESS_RADIX = HEX;\n');
% fprintf(fid3,'DATA_RADIX = HEX;\n\n');
% fprintf(fid3,'CONTENT BEGIN\n');

count = 0;
for r = 3:rows
    for c = 1:cols
		grey = 	uint8(imgresized(r,c));
		cc(((r-3)*256+c),1) = uint8(imgresized(r,c));
%         fprintf(fid3,'%4u : %4u;\n',count, grey);
        count = count + 1;
    end
end
% fprintf(fid3,'END;');
% fclose(fid3);


% fid4 = fopen(outfname4,'w');
% 
% fprintf(fid4,'-- %3ux%3u Grey Scale Image 1\n\n',rows,cols);
% fprintf(fid4,'WIDTH = 72;\n');
% fprintf(fid4,'DEPTH = %4u;\n\n',904);
% fprintf(fid4,'ADDRESS_RADIX = HEX;\n');
% fprintf(fid4,'DATA_RADIX = HEX;\n\n');
% fprintf(fid4,'CONTENT BEGIN\n');

count = 0;
number = 1;
for r = 1:16256		
		r3=a(number+3,1);
		r2=a(number+2,1);
		r1=a(number+1,1);
		r0=a(number,1);
%         fprintf(fid4,'%4u : %02x%02x%02x%02x%02x%02x%02x%02x%02x;\n',count, r8,r7,r6,r5,r4,r3,r2,r1,r0);
        count = count+1;
		number=number+4;
end
% fprintf(fid4,'END;');
% fclose(fid4);

% fid5 = fopen(outfname5,'w');
% 
% fprintf(fid5,'-- %3ux%3u Grey Scale Image 1\n\n',rows,cols);
% fprintf(fid5,'WIDTH = 72;\n');
% fprintf(fid5,'DEPTH = %4u;\n\n',904);
% fprintf(fid5,'ADDRESS_RADIX = HEX;\n');
% fprintf(fid5,'DATA_RADIX = HEX;\n\n');
% fprintf(fid5,'CONTENT BEGIN\n');

count = 0;
number = 1;
for r = 1:16256		
		r3=b(number+3,1);
		r2=b(number+2,1);
		r1=b(number+1,1);
		r0=b(number,1);
%         fprintf(fid5,'%4u : %02x%02x%02x%02x%02x%02x%02x%02x%02x;\n',count, r8,r7,r6,r5,r4,r3,r2,r1,r0);
        count = count+1;
		number=number+4;
end
% fprintf(fid5,'END;');
% fclose(fid5);


% fid6 = fopen(outfname6,'w');
% 
% fprintf(fid6,'-- %3ux%3u Grey Scale Image 1\n\n',rows,cols);
% fprintf(fid6,'WIDTH = 72;\n');
% fprintf(fid6,'DEPTH = %4u;\n\n',904);
% fprintf(fid6,'ADDRESS_RADIX = HEX;\n');
% fprintf(fid6,'DATA_RADIX = HEX;\n\n');
% fprintf(fid6,'CONTENT BEGIN\n');

count = 0;
number = 1;
for r = 1:16256		
		r3=cc(number+3,1);
		r2=cc(number+2,1);
		r1=cc(number+1,1);
		r0=cc(number,1);
%         fprintf(fid6,'%4u : %02x%02x%02x%02x%02x%02x%02x%02x%02x;\n',count, r8,r7,r6,r5,r4,r3,r2,r1,r0);
        count = count+1;
		number=number+4;
end
% fprintf(fid6,'END;');
% fclose(fid6);

fid7 = fopen(coeR,'w');
fprintf(fid7,'//BRAM R Header File\n');
fprintf(fid7,'//Author: Jonathan Ganyer\n\n');
fprintf(fid7,'int bromr[16256] = {\n');
count = 0;
number = 1;
for r = 1:16256		
		r3=a(number+3,1);
		r2=a(number+2,1);
		r1=a(number+1,1);
		r0=a(number,1);
        if(r==16256)
           fprintf(fid7,'0x%02x%02x%02x%02x%\n',r3,r2,r1,r0);
        else 
        fprintf(fid7,'0x%02x%02x%02x%02x,\n',r3,r2,r1,r0);
        end
        count = count+1;
		number=number+4;
end
fprintf(fid7,'};\n');
fclose(fid7);

fid8 = fopen(coeP,'w');
fprintf(fid8,'//BRAM P Header File\n');
fprintf(fid8,'//Author: Jonathan Ganyer\n\n');
fprintf(fid8,'int bromp[16256] = {\n');
count = 0;
number = 1;
for r = 1:16256
		r3=b(number+3,1);
		r2=b(number+2,1);
		r1=b(number+1,1);
		r0=b(number,1);
        if(r==16256)
           fprintf(fid8,'0x%02x%02x%02x%02x\n',r3,r2,r1,r0);
        else 
        fprintf(fid8,'0x%02x%02x%02x%02x,\n',r3,r2,r1,r0);
        end
        count = count+1;
		number=number+4;
end
fprintf(fid8,'};\n');
fclose(fid8);

fid9 = fopen(coeQ,'w');
fprintf(fid9,'//BRAM Q Header File\n');
fprintf(fid9,'//Author: Jonathan Ganyer\n\n');
fprintf(fid9,'int bromq[16256] = {\n');
count = 0;
number = 1;
for r = 1:16256
		r3=cc(number+3,1);
		r2=cc(number+2,1);
		r1=cc(number+1,1);
		r0=cc(number,1);
        if(r==16256)
           fprintf(fid9,'0x%02x%02x%02x%02x\n',r3,r2,r1,r0);
        else 
        fprintf(fid9,'0x%02x%02x%02x%02x,\n',r3,r2,r1,r0);
        end
        count = count+1;
		number=number+4;
end
fprintf(fid9,'};\n');
fclose(fid9);
