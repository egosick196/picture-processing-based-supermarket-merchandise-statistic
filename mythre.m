function [ B ] = mythre( pic )

rgb = lightcomp(pic);
g = rgb2gray(rgb);

thre_val = graythresh(g);  %自适应求阈值
b = imbinarize(g,thre_val);
mianji = size(rgb,1) * size(rgb,2);
B = bwareaopen(b, round(0.0005 * mianji));

if sum(sum(B)) > (mianji - sum(sum(B)))
    B = 1 - B;
end