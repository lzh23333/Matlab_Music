function f = calc_f(tone, basic_f)
%根据传进的曲调来计算对应频率
%tone应为0——8的整数，表示乐音
%basic_f为基调频率
if(tone ~= 0)
    multiply = [0,2,4,5,7,9,11,12];
    f = basic_f * (2^(multiply(tone)/12));
else
    f = 0;
end

