function [ROI] =f_conComp_analysis(P_image,grayImage)
[x, y] = size(P_image);
whole = x * y; %图像总面积
mask = zeros(x, y);
j = 1;

connComp = bwconncomp(P_image);  % Find connected components
threefeature = regionprops(connComp,'Area','BoundingBox');
broder = [threefeature.BoundingBox];  %[x y width height]字符的区域
area = [threefeature.Area];  %区域面积

%% ROI细分
for i = 1 : connComp.NumObjects
    leftx = floor(broder((i-1) * 4 + 1));
    lefty = floor(broder((i-1) * 4 + 2));
    width = broder((i-1) * 4 + 3);
    height = broder((i-1) * 4 + 4);
    
    if (area(i) < 0.2 * mean(area)) || (area(i) > whole * 0.4)
        P_image(connComp.PixelIdxList{i})=0;
    else
        rectangle('Position',[leftx,lefty,width,height], 'EdgeColor','g');
        mask(lefty + 6 : lefty + height - 5, leftx+1 : leftx+width) = 1 ;
        j = j + 1;
    end
end

ROI = mask .* double(grayImage);