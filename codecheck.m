function [checked] = codecheck(matched)

load('.\data\category.mat');
str1 = [num2str(690), num2str(691), num2str(692), num2str(693), num2str(694), num2str(695), num2str(696)];
str2 = reshape(str2num(str1'),[],7)';

checked = 0;
for i = 1 : 7 
    start = strfind(matched, str2(i, :));  %确认条码数值串的起始位置
    if ~isempty(start)
        ean = matched(1, start : start + 12);  %检测到的商品条码
        
        for j = 1 : kind_num
            check_flag = strfind(ean, devide(j, :));  %商品种类确定
            if ~isempty(check_flag)
                checked = j;
                break;
            end
        end
        
        break;
    end
end

if checked ~= 0  %确定接下来要识别图片中商品的种类
    following = checked;
    save('.\data\following.mat', 'following');
end