%将A中各个谐波分量写入矩阵中
function y = write_xiebo(input_A)
y = [];
x = input_A(2:3,:);
[r,c] = size(x);
for i = 1:c 
    y(x(1,i)) = x(2,i);
end
y
