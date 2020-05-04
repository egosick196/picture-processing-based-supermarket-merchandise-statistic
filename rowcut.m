function [ cout, line_cut ] = rowcut( B )

[X,Y] = find(B == 1);
edge_cut = B(min(X): max(X), min(Y): max(Y));  %剔除周围大的空白

[m, ~] = size(edge_cut);  %寻找行间空白
countY = 256 * ones(m,1);  %保留第一行和最后一行
for i = 1 : m-2  
  if isempty(find(edge_cut(i+1, :),1))
      countY(i+1, 1) = countY(i, 1) + 1;  %紧挨字的空白像素行被标记为256
  else
      countY(i+1, 1) = 255;  %有字部分被标为255
  end
end

[white_mark, ~] = find(countY == 256);  %行切分
cout = size(white_mark) - 1;
line_cut = {cout};
for j = 1 : cout
    row = edge_cut(white_mark(j):white_mark(j+1), :);
    [X1,~] = find(row == 1);
    line_cut{j} = row(min(X1): max(X1), :);  %消除行间黑边
end




