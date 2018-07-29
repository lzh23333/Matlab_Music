function T = findT_corr(corr_f,x)
%从自相关函数中找到相邻的极值点间的间隔，从而找到周期
%corr_F为自相关函数
%x为对应的横坐标
%T为输出的周期

%先取x>=0部分的值
corr_f = corr_f(x>=0);
x = x(x>=0);

max_point = corr_f(x==0);
index = find_localmax(corr_f,10,0.3*max_point);     %寻找极值点对应下标
%{
figure(97);
plot(x,corr_f);
hold on;
scatter(index,corr_f(index),'*');
%}

x_d = diff(index);      %求差
T = sum(x_d)/length(x_d);   %求平均周期(注意，非整数）
