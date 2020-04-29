parfor i = 1 : sequ_num
    x = num2str(i - 1);
    imwrite(sequence{i}, strcat('.\word\word-', x, '.jpg'))
end