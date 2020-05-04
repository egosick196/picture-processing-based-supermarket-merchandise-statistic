clear;
cate_tab = readtable('category.xlsx');
ean = cate_tab.ean_code;
category = table2cell(cate_tab);

kind_num = length(ean);
devide = zeros(kind_num, 13);
for i = 1 : kind_num
   devide(i, :) = str2num(num2str(ean(i))')';
end

save('.\data\category.mat', 'category', 'devide', 'kind_num');