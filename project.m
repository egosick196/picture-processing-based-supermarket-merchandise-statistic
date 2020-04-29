clear; clc;

%% 提取ROI
[zheng, color] = tilt_corrc('.\pic\7.jpg');  %zheng是灰度图，color是彩色图
[ mark ] = MSERmain( zheng );
marked = uint8(mark);
[cout, gray_cut, color_cut] = roiRowcut(marked, color);
[seg_num, color_seg] = roicut( cout, gray_cut, color_cut );

%% 光照补正、切割及识别
sequ_num = 0;
sequence = {seg_num};
parfor i = 1 : seg_num
    rgb = lightcomp(color_seg{1, i});
    pic = mythre(rgb);
    [row_num, line_cut] = rowcut(pic);
    [total_num, final_cut] = refine_wordcut(row_num, line_cut);
    sequence = [sequence, final_cut];
    sequ_num = sequ_num + total_num;
end
%matched = GISTmatch( total_num );
