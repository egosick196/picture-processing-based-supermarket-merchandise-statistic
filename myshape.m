function [ shape_num, shaped ] = myshape( num, sequence )

shape_num = 0;
shaped = {};
parfor k = 1 : num
    bina = sequence{1, k};
    
    [testx, testy] = size(bina);  %³ß´çÉ¸Ñ¡
    if (testx > 35) && (testy > 35) && (testx < 300) && (testy < 300) && ((testy / testx) < 3)
    else
        continue;
    end
    
    shaped = [shaped, {imresize(bina, [35 30])}];
    shape_num = shape_num + 1;
end