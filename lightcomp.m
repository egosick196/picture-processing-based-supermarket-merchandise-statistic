function [ rgb ] = lightcomp( color_seg )

[h,s,v] = rgb2hsv(color_seg); %转到hsv空间，对亮度v处理

% 高斯滤波
HSIZE = min(size(color_seg,1),size(color_seg,2));%高斯卷积核尺寸
q = sqrt(2);
SIGMA1 = 15; %论文里面的c
SIGMA2 = 80;
SIGMA3 = 250;

F1 = fspecial('gaussian',HSIZE,SIGMA1/q);
F2 = fspecial('gaussian',HSIZE,SIGMA2/q) ;
F3 = fspecial('gaussian',HSIZE,SIGMA3/q) ;
gaus1 = imfilter(v, F1, 'replicate');
gaus2 = imfilter(v, F2, 'replicate');
gaus3 = imfilter(v, F3, 'replicate');
gaus = (gaus1+gaus2+gaus3)/3;    %多尺度高斯卷积，加权，权重为1/3

%二维伽马卷积

m = mean(gaus(:));
gama = power(0.5,((m-gaus)/m)); %根据公式gamma校正处理，论文公式有误
out = (power(v,gama));
rgb = hsv2rgb(h,s,out);  %转回rgb空间显示