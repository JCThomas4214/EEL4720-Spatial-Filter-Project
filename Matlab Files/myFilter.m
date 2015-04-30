function [ pic ] = myFilter( infile, numrows, numcols, mult)

img = rgb2gray(imread(infile));
imgresized = imresize(img, [numrows numcols]);
pic = zeros(numrows,numcols);
% hexImg = zeros(numrows-2, numcols-2);

[rows, cols, rgb] = size(imgresized);

for r = 1:rows
    for c = 1:cols		
		pic(r,c) = uint8(imgresized(r,c));        
    end
end
for r = 1:numrows-2
    for c = 1:numcols-2
        sum = ((-1)*pic(r,c))+((-1)*pic(r,c+1))+((-1)*pic(r,c+2))+((-1)*pic(r+1,c))+((mult)*pic(r+1,c+1))+((-1)*pic(r+1,c+2))+((-1)*pic(r+2,c))+((-1)*pic(r+2,c+1))+((-1)*pic(r+2,c+2));        
        final = (sum)/mult;
        if final >= 0
            filteredPic(r,c) = final;
        else
            filteredPic(r,c) = 0;
        end
    end
end

  
 
  
end

