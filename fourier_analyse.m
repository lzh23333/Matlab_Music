function [F,f] = fourier_analyse(signal,fs)
%利用课上的矩阵直接做傅里叶分析
%signal为输入信号，fs为采样频率
%F为频谱，f为对应频率
L = length(signal);
OMG = fs*2*pi;
K = 40000;
f = linspace(-OMG/2,OMG/2-OMG/K,K)';
t = linspace(0,(L-1)/fs,L)';
U = exp(-j*kron(f,t.'));
[r,c]=size(kron(f,t.'));
F = 1/fs*U*signal;
f = f/2/pi;
