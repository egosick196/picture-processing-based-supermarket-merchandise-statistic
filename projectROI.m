clear; clc;

[zheng, color] = tilt_corrc('.\pic\6.jpg');
[ mark ] = MSERmain( zheng );
ROI = uint8(mark);
[cout, gray_cut, color_cut] = roiRowcut(ROI, color);
[total_num, color_seg] = roicut( cout, gray_cut, color_cut );