function [ total_num, color_seg ] = roicut( cout, gray_cut, color_cut )

total_num = 0;
color_seg = {cout - 1};
for k = 1 : cout
    b = gray_cut{k};
    color_row = color_cut{k};
    
    [~, O] = size(b);  %寻找列间空白
    countX = 256 * ones(O, 1);  %保留最后一列
    countX(1, 1) = 257;  %不保留第一列
    
    for a = 1 : O-2  %保留第一列和最后一列
      if isempty(find(b(:, a),1))
          countX(a+1, 1) = countX(a, 1) + 1;  %紧挨字的空白像素列被标记为256
      else
          countX(a+1, 1) = 255;
      end
    end
    
    [first, ~] = find(countX == 255, 1);
    [white, ~] = find(countX == 256);  %列切分
    white = [first, white'];
    white = white';
    [cout, ~] = size(white);
    
    for i = 1 : cout - 1
        colorarray = color_row(:, white(i) : white(i+1), :);
        grayword1 = b(:, white(i) : white(i+1));
        [X1,Y1] = find(grayword1);
        colorword = colorarray(min(X1): max(X1), min(Y1): max(Y1), :);
        
        labley = num2str(total_num);
        if isempty(colorword)
        else
           imwrite(colorword, strcat('.\ROI\roi-',labley, '.jpg'))
           total_num = total_num + 1;
           color_seg{total_num} = colorword;
        end
    end      
end        