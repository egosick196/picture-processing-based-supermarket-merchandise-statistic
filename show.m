parfor i = 1 : seg_num
    x = num2str(i - 1);
    imwrite(color_seg{i}, strcat('.\word\word-', x, '.jpg'))
end