function [ cout, gray_cut, color_cut ] = roiRowcut( B, color )

[m, ~] = size(B);  %寻找行间空白
countY = 256 * ones(m,1);  %保留第一行和最后一行
flag = 1;
for i = 1 : m - 2  
  if isempty(find(B(i+1, :), 1))  %找非零元素，若无则逻辑值为1
      countY(i+1, 1) = countY(i, 1) + 1;
      flag = 1;
  elseif flag == 1
      countY(i+1, 1) = 256;
      flag = 0;
  else
      countY(i+1, 1) = 255;
  end
end

[white_mark, ~] = find(countY == 256);  %行切分
[count, ~] = size(white_mark);
cout = (count - 2)/2;
gray_cut = {cout};
color_cut = {cout};

for j = 1 : cout
    gray_cut{j} = B(white_mark(2*j):white_mark(2*j+1), :);
    color_cut{j} = color(white_mark(2*j):white_mark(2*j+1), :, :);
end




