function [] = checkandwrite(matched)

load('.\data\following.mat'); load('.\data\category.mat');
timearray = clock; this = timearray(1, 1);
last = this - 1; before = last - 1;
str1 = [num2str(this), num2str(last), num2str(before)];
str2 = reshape(str2num(str1'),[],3)';

start1 = strfind(matched, str2(1, :));  %确认年份数值串的起始位置
flag1 = length(start1);
start2 = strfind(matched, str2(2, :));
flag2 = length(start2);
start3 = strfind(matched, str2(3, :));
flag3 = length(start3);

start = [start1, start2, start3];
flag = flag1 + flag2 + flag3;
isemerge = strings(1, flag);

for i = 1 : flag 
    if matched(1, start(1, i) + 4) == 0  %检查年份数值串的格式，月份是否含0
        produ = matched(1, start(1, i) : start(1, i) + 7);  %分隔数字的合并
        date0(1, 1) = 1000 * produ(1, 1) + 100 * produ(1, 2) + 10 * produ(1, 3) + produ(1, 4);
        date0(1, 2) = 10 * produ(1, 5) + produ(1, 6);
        date0(1, 3) = 10 * produ(1, 7) + produ(1, 8);
    else
        produ = matched(1, start(1, i) : start(1, i) + 6);
        date0(1, 1) = 1000 * produ(1, 1) + 100 * produ(1, 2) + 10 * produ(1, 3) + produ(1, 4);
        date0(1, 2) = produ(1, 6);
        date0(1, 3) = 10 * produ(1, 7) + produ(1, 8);
    end

    dayprod = datetime(date0);  %生产日期
    dayexpire = dayprod + calmonths(category{following, 3}) + caldays(category{following, 4});  %过期日期
    Now = timearray(1, 1 : 3); 
    
    daynow = datetime(Now);  %现在日期
    due = duration(dayexpire - daynow,'Format','d');  %到过期为止剩余时间

    if due < category{following, 5}  %是否需要加入促销判断
        isemerge(1, i) = 'yes';
    else
        isemerge(1, i) = 'no';
    end
end

[~, index] = sort(start);  %输出提示信息
msg = isemerge(index);
warn = find(strcmp(msg, 'yes'));
str = num2str(warn);

situate = '';
for j = 1 : length(str)
    situate = strcat(situate, '、', str(j));
end

if isempty(warn)
    uiwait(msgbox('无商品需要进行促销','检测结果','modal'));
else
    situate(1) = '';
    warn_str = strcat('从上到下第', situate, '件商品需加入促销');
    uiwait(msgbox(warn_str,'检测结果','modal'));
end

if exist('.\data\统计表.xlsx', 'file')
else
    kind = cate_tab.kind;
    total_number = zeros(kind_num, 1);
    number_needed_promotion = zeros(kind_num, 1);
    T = table(kind, total_number, number_needed_promotion);
    writetable(T, '.\data\统计表.xlsx');
end

results = readtable('.\data\统计表.xlsx');
sum = results.total_number(following) + flag;
sum_promo = results.number_needed_promotion(following) + length(warn);
results.total_number(following) = sum;
results.number_needed_promotion(following) = sum_promo;
writetable(results, '.\data\统计表.xlsx');