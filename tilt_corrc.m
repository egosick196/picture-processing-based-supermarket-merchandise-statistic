function [ I5, color ] = tilt_corrc( str )

%% 倾斜校正
pic = imread(str);
B = rgb2gray(pic);

I2 = wiener2(B, [8, 8]); 
I3 = edge(I2, 'sobel', 'horizontal');  %边缘求取

theta = 0 : 179;
r = radon(I3, theta);  %直线检测
[m, n] = size(r); 
c = 1; 

for i = 1 : m
   for j = 1 : n
      if r(1,1) < r(i,j)
         r(1,1) = r(i,j);
         c = j;
      end
   end
end

rot_theta = 90 - c; 
I5 = imrotate(B, rot_theta, 'crop');
color = imrotate(pic, rot_theta, 'crop');