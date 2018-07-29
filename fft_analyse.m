function [F,f] = fft_analyse(signal,fs)
%根据输入的信号signal以及对应的采样频率，返回频率谱F与对应频率f
L = length(signal);
T = 1/fs;
OMG = fs;
f = linspace(-OMG/2,OMG/2-OMG/L,L);
t = linspace(0,(L-1)/fs,L);

F = fft(signal);
F = fftshift(F);
F = abs(F)/L;
%{
plot(f,F);
xlabel('w(Hz)');
ylabel('abs(F)');
%}