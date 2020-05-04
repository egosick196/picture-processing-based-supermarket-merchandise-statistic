function [ total_num, final_cut ] = refine_wordcut( cout, line_cut )

total_num = 0;
final_cut = {};
for k = 1 : cout
    b = line_cut{1, k};    
    [X,Y] = find(b == 1);
    B = b(min(X): max(X), min(Y): max(Y));  %剔除周围大的空白

    
    [~, O] = size(B);  %寻找列间空白
    countX = 256 * ones(O, 1);
    
    for a = 1:O-2  %保留第一列和最后一列
      if isempty(find(B(:, a+1),1))
          countX(a+1, 1) = countX(a, 1) + 1;  %紧挨字的空白像素列被标记为256
      else
          countX(a+1, 1) = 255;
      end
    end
    
    [white, ~] = find(countX == 256);  %列切分
    cout = size(white);
    
    for b = 1 : cout-1
        row = B(:, white(b):white(b+1));
        [X1,Y1] = find(row == 1);
        cut = row(min(X1): max(X1), min(Y1): max(Y1));
        
        if ~isempty(cut)
            total_num = total_num + 1;
            final_cut{total_num} = cut;
        end
    end      
end        