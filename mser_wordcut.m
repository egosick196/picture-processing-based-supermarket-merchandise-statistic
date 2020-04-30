function [ total_num, final_cut ] = mser_wordcut( word_num, word_cut )

total_num = 0;
final_cut = {};
for k = 1 : word_num
    gray = word_cut{1, k};    
    grayImage = uint8(gray);

    mserRegions = detectMSERFeatures(grayImage);
    mserRegionsPixels = vertcat(cell2mat(mserRegions.PixelList));
    mserMask = false(size(grayImage));
    ind = sub2ind(size(mserMask), mserRegionsPixels(:,2), mserRegionsPixels(:,1));
    mserMask(ind) = true;
    connComp = bwconncomp(mserMask);  % Find connected components
    
    if connComp.NumObjects > 1
        threefeature = regionprops(connComp,'BoundingBox');
        broder = [threefeature.BoundingBox];  %[x y width height]×Ö·ûµÄÇøÓò

        for i = 1 : connComp.NumObjects  
            leftx = floor(broder((i-1)*4+1));
            lefty = floor(broder((i-1)*4+2));
            width = floor(broder((i-1)*4+3));
            height = floor(broder((i-1)*4+4));
            cut{i} = grayImage(lefty + 1 : lefty + height, leftx + 1 : leftx + width);
            total_num = total_num + 1;
        end
    else
        cut = word_cut;
        total_num = total_num + 1;
    end
    final_cut = {final_cut, cut};
end