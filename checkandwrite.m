timearray = clock;
this = timearray(1, 1);
last = this - 1;
before = last - 1;
str1 = [num2str(this), num2str(last), num2str(before)];
str2 = reshape(str2num(str1'),[],3)';

start = strfind(matched, str2(1, :));  %确认年份数值串的起始位置
flag = 0;
if isempty(start)
    start = strfind(matched, str2(2, :));
    flag = 1;
end
if isempty(start)
    start = strfind(matched, str2(3, :));
    flag = 2;
end

if matched(1, start + 4) == 0  %检查年份数值串的格式，月份是否含0
    produ = matched(1, start : start + 7);  %分隔数字的合并
    date0(1, 1) = 1000 * produ(1, 1) + 100 * produ(1, 2) + 10 * produ(1, 3) + produ(1, 4);
    date0(1, 2) = 10 * produ(1, 5) + produ(1, 6);
    date0(1, 3) = 10 * produ(1, 7) + produ(1, 8);
else
    produ = matched(1, start : start + 6);
    date0(1, 1) = 1000 * produ(1, 1) + 100 * produ(1, 2) + 10 * produ(1, 3) + produ(1, 4);
    date0(1, 2) = produ(1, 6);
    date0(1, 3) = 10 * produ(1, 7) + produ(1, 8);
end

dayprod = datetime(date0);  %生产日期
dayexpire = dayprod + calmonths(category{1, 2}) + caldays(category{1, 3});  %过期日期
Now = timearray(1, 1 : 3);  
Now(1, 1) = Now(1, 1) - flag;
daynow = datetime(Now);  %现在日期
due = duration(dayexpire - daynow,'Format','d');  %到过期为止剩余时间

if due < category{1, 4}  %是否需要加入促销
    isemerge = 'yes';
else
    isemerge = 'no';
end
