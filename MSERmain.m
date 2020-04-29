function [ ROI ] = MSERmain( grayImage )

%% mser区域提取
mserRegions = detectMSERFeatures(grayImage);
mserRegionsPixels = vertcat(cell2mat(mserRegions.PixelList));

%% 把mser区域的坐标系数取出来，然后将相应系数的地方赋值为真。取出mser区域。
mserMask = false(size(grayImage));
ind = sub2ind(size(mserMask), mserRegionsPixels(:,2), mserRegionsPixels(:,1));
mserMask(ind) = true;

%% 连通域分析
[p_image,cwidth] = conComp_analysis(mserMask);
figure;imshow(grayImage);
wi= median(cwidth(:))/2;
se1=strel('line',wi,0);
p_image_dilate= imclose(p_image,se1);

%% 细滤除
[ROI] = f_conComp_analysis(p_image_dilate,grayImage);