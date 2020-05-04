function [ total_num, final_cut ] = mser_wordcut( word_num, word_cut )

total_num = 0;
final_cut = {};
parfor k = 1 : word_num
    gray = word_cut{1, k};    
    grayImage = 255 * uint8(gray);

    [testx, testy] = size(grayImage);  %检查图片大小
    if ((testx > 35) && (testy > 35)) && ((testx < 800) && (testy < 800))
    else
        continue;
    end
    
    mserRegions = detectMSERFeatures(grayImage);
    flag = mserRegions.PixelList;
    
    if isa(flag, 'cell')  %当只有一个MSER区时保证正确地坐标传递
        mserRegionsPixels = vertcat(cell2mat(flag));  
    else
        mserRegionsPixels = flag;
    end
    
    if isempty(mserRegionsPixels)  %是否存在MSER区域
        final_cut = [final_cut, {grayImage}];
        total_num = total_num + 1;
    else
        mserMask = false(size(grayImage));
        ind = sub2ind(size(mserMask), mserRegionsPixels(:,2), mserRegionsPixels(:,1));
        mserMask(ind) = true;
        connComp = bwconncomp(mserMask);  % Find connected components

        if connComp.NumObjects > 1
            threefeature = regionprops(connComp,'BoundingBox');
            broder = [threefeature.BoundingBox];  %[x y width height]字符的区域

            for i = 1 : connComp.NumObjects  
                leftx = floor(broder((i-1)*4+1)); lefty = floor(broder((i-1)*4+2));
                width = floor(broder((i-1)*4+3)); height = floor(broder((i-1)*4+4));
                final_cut = [final_cut, {grayImage(lefty + 1 : lefty + height, leftx + 1 : leftx + width)}];
                total_num = total_num + 1;
            end
        else
           final_cut = [final_cut, {grayImage}];
           total_num = total_num + 1;  
        end
    end
end