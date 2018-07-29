%对wave2proc进行频谱分析
load('Guitar.mat');
fs = 8000;
single_cycle = wave2proc(1:24);
[F,f] = fft_analyse(single_cycle,fs);
[F,t] = fft_analyse(wave2proc,fs);
multi_cycle = repmat(wave2proc,10,1);
[F,f] = fft_analyse(multi_cycle,fs);

threshold = max(F(f>=-20 & f<=20))  %取0频点附近最大值作为阈值
A = find(F>threshold);
f_set = f(A);
plot(f,F,f(A),F(A),'*');


    