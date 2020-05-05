function [ matched ] = GISTmatch( total_num, total_sequ )

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
    img1 = total_sequ{i};
    gist1 = LMgist(img1, '', param);
    D = zeros(10, 1);

    % Computing gist:
    parfor j = 1 : 18
        % Distance between the two images:
        D(j, 1) = sum((gist1-gist2(j, :)).^2);
    end
    
    if min(D) < 0.7
        [matched(1, fit), ~] = find(D == min(D));
        matched(1, fit) = matched(1, fit) - 1;
        fit = fit + 1;
    end
    
    [~, ex] = find(matched > 9 & matched ~= 255);
    if isempty(ex)
    else
        for k = 1 : length(ex)
            switch matched(1, ex(k))
            case 10
                matched(1, ex(k)) = 1;
            case 11
                matched(1, ex(k)) = 1;
            case 12
                matched(1, ex(k)) = 2;
            case 13
                matched(1, ex(k)) = 3;
            case 14
                matched(1, ex(k)) = 3;
            case 15
                matched(1, ex(k)) = 4;
            case 16
                matched(1, ex(k)) = 6;
            case 17
                matched(1, ex(k)) = 9;
            end
        end
    end
end