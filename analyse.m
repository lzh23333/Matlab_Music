function [fourier_f,freq] = analyse(signal,T,fs)
%输出傅里叶变换后的信号
%signal为输入带周期的信号
%T为信号周期
%fs为采样频率
%freq为对应的频率

%先进行去除噪声
L = length(signal);
nums = ceil(L/T)-1;
if(nums >= 10) 
    nums = 10;   
end
signal = signal(1:ceil(nums*T)-1);  %取整数个周期进行分析

signal2 = resample(signal,10,1);     %乘10采样
f = zeros(1,ceil(10*T)-1);           %生成单周期
multiplier = ones(1,nums);           %幅度因子
one_cycle = ceil(10*T)-1;            %10倍采样后单周期点数
%计算每个周期的修正因子
for k = 1:nums
    last = k*one_cycle;
    if(last > length(signal2))
        last = length(signal2);
    end
    multiplier(k) = max(signal2((k-1)*one_cycle+1:last))/ max(signal2(1:one_cycle));
end

for k = 1:ceil(10*T)-1
    for i = 0:nums-1
        if(i*(ceil(10*T)-1)+k > length(signal2))
            f(k) = f(k) + signal2(length(signal2))/multiplier(i+1);
            break;
        else
            f(k) = f(k) + signal2(i*(ceil(10*T)-1)+k)/multiplier(i+1);
        end 
    end
    f(k) = f(k)/nums;
end
%得到单周期序列f
new_f = repmat(f,1,nums);
real_signal = resample(new_f,1,10);
%{
figure(1212211);
subplot(1,2,1);
plot(real_signal);
title('处理过后');
subplot(1,2,2);
plot(signal);
title('处理前');
%}
input_signal = repmat(real_signal,1,10);
[fourier_f,freq] = fft_analyse(input_signal,fs);

