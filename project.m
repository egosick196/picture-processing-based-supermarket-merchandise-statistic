clear; clc;

%% 提取ROI
[zheng, color] = tilt_corrc('.\pic\12.jpg');  %zheng是灰度图，color是彩色图
[ mark ] = MSERmain( zheng );
marked = uint8(mark);
[cout, gray_cut, color_cut] = roiRowcut(marked, color);
[seg_num, color_seg] = roicut( cout, gray_cut, color_cut );

%% 光照补正、切割
sequ_num = 0;
sequence = {};
parfor i = 1 : seg_num
    rgb = lightcomp(color_seg{1, i});
    pic = mythre(rgb);
    [row_num, row_cut] = rowcut(pic);
    [word_num, word_cut] = refine_wordcut(row_num, row_cut);
    [num, cut] = mser_wordcut(word_num, word_cut);
    
    sequence = [sequence, cut];
    sequ_num = sequ_num + num;
end

%% 匹配识别
[ shape_num, shaped ] = myshape( sequ_num, sequence );
matched = GISTmatch( shape_num, shaped );
ean_checked = codecheck(matched);

if ean_checked == 0
   
end