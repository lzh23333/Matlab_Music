%对realwave进行预处理
load('Guitar.mat');
f = resample(realwave,10,1);                                    %提高采样率重采样
new_f = 0*realwave;
for k = 1:length(realwave)
    for i = 0:9
        new_f(k) = new_f(k) + f(i*length(realwave)+k);          %对应周期的信号相加
    end
    new_f(k) = new_f(k)/10;                                     %求平均
end
wave_proc2 = repmat(new_f,10,1);
wave_proc = resample(wave_proc2,1,10);                          %降采样

%画图
subplot(3,1,1);
plot(realwave);
title('realwave');
subplot(3,1,2);
plot(wave2proc);
title('wave2proc');
subplot(3,1,3);
plot(wave_proc);
title('wave\_proc');

corr = sum(wave2proc.*wave_proc) /norm(wave2proc)/norm(wave_proc) %求相关系数
%fourier分析
fs = 8000;
figure(2);
[F,f] = fft_analyse(realwave,8000);
[F2,f2]=fft_analyse(wave_proc,8000);
subplot(1,2,1);
plot(f,abs(F));
title('realwave');
subplot(1,2,2);
plot(f2,abs(F2));
title('wave\_proc');
