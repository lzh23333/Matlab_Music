function y = similar(f,number)
%判定两个数(同符号)是否可以认为相等
y = zeros(1,length(y));
for i = 1:length(f)
    a = abs(f(i)-number)/min(f(i),number);
    if(a<=2*e-2)
        y(i)=1;
    else
        y(i)=0;