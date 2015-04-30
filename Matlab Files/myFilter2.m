function [ filteredPic ] = myFilter2( pic, numrows, numcols, mult)

filteredPic = zeros(numrows-2, numcols-2);

tic
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
toc
% 
%   
%   figure(2);
%   finalImg = uint8(filteredPic);
%   imshow(finalImg * 16);
%   
end