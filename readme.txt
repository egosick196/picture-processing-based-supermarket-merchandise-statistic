1. 程序主函数为project，categener和paragener为用于生成所需参数的脚本。其他函数为主程序所调用。
2. paragener读取存放于mask文件夹下的模板图片，生成模板的特征向量组“gist2.mat”保存在data文件
夹下，运行project时自动读取进行匹配。
3. categener脚本允许导入商品种类、保质期和过期期限，生成系统变量“category.mat”供主程序运行时调用。
4. 程序依赖于相对路径，整个文件夹可任意放置。
5. GIST文件夹来自GIST算法原作者，未作修改，运行project前请将其添加到MATLAB系统路径。
6. 待识别图片应为RGB类型，放在pic文件夹下，修改project.m中tilt_corrc()中图片名即可处理该图片。
7. 