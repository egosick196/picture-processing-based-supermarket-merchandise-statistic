clear;
clear param
param.imageSize = [35 30]; % it works also with non-square images(use the most common aspect ratio in your set)
param.orientationsPerScale = [12 12 12 12]; % number of orientations per scale
param.numberBlocks = 3;
param.fc_prefilt = 3;
gist2 = zeros(11, 432);

parfor j = 1 : 17  %可供匹配的模板数量，包括字体变化
    lablex = num2str(j - 1);
    pic = imread(strcat('.\mask\word-',lablex, '.jpg'));   
    gist2(j, :) = LMgist(pic, '', param);
end

save('.\data\gist2.mat', 'gist2');