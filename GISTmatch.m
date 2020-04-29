function [ matched ] = GISTmatch( total_num )

matched = 255 * ones(1, total_num);
fit = 1;
load('.\data\gist2.mat');

% GIST Parameters:
clear param
param.imageSize = [35 30]; %it works also with non-square images(use the most common aspect ratio in your set)
param.orientationsPerScale = [12 12 12 12]; % number of orientations per scale
param.numberBlocks = 3;
param.fc_prefilt = 3;

% Load images
for i = 1 : total_num
    labtomatch = num2str(i - 1);
    img1 = imread(strcat('.\word\word-', labtomatch, '.jpg'));
    gist1 = LMgist(img1, '', param);
    D = zeros(10, 1);

    % Computing gist:
    parfor j = 1 : 11
        % Distance between the two images:
        D(j, 1) = sum((gist1-gist2(j, :)).^2);
    end
    
    if min(D) < 0.5
        [matched(1, fit), ~] = find(D == min(D));
        matched(1, fit) = matched(1, fit) - 1;
        fit = fit + 1;
    end
    
    [~, ex] = find(matched == 10);
    if isempty(ex)
    else
        matched(1, ex) = 1;
    end
end