%
fmt = audioread('fmt.wav');
%{
figure(10086);
subplot(1,2,1);
plot(fmt(1:1000));
title('处理前');
%}
fs = 8000;
t = linspace(0,(length(fmt)-1)/fs,length(fmt));

%对静音部分进行处理
threshold = 0.005;              %静音阈值
A = find(fmt>threshold);        %找到所有大于阈值的index
begin = A(1);                   %取第一个index
final = A(end-1);               %取最后一个index
fmt = fmt(begin:final);         %定义为信号有效范围

%{
subplot(1,2,2);
plot(fmt(1:1000));
title('处理后');
%}

step = 25;                      %计算能量步长为25
E = calc_energy(fmt,step);

pace = 750;                    %设置步长  
threshold_E = 0.1;              %设置阈值
index = find_localmax(E,pace,threshold_E);  %寻找极大值点
step_t = index/fs;                   %从而计算出对应时间
[jiepai,step_time] = time_analyse(index,length(E),fs);%计算每段的节拍、单节拍的时间

msg = string();
guitar_weight = zeros(12,28);            %记录谐波分量
for i = 1:length(index)-1
%i = 13;
    L2 = index(i+1)-index(i);
    signal = fmt(index(i)+ceil(L2/4):index(i+1)-ceil(L2/4));
    [a,b] = xcorr(signal,'unbiased');%自相关函数计算

    T = findT_corr(a,b)             %求得周期
    [fourier_f,f] = analyse(signal,T,fs);%进行fourier变换
    fourier_f = fourier_f(f>=0);    %保留正频率部分
    f = f(f>=0);                    
    f_index = find_localmax(fourier_f,50,0.01*max(fourier_f));%找到极值点
    %{
    figure(55555);
    subplot(ceil(length(index)/2),2,i);
    plot(f,fourier_f);
    title(num2str(i));
    xlabel('');
    ylabel('');
    
    hold on;                        
    scatter(f(f_index),fourier_f(f_index),'*');
    hold off;
    %}
    
    A = recognize(f(f_index),fourier_f(f_index));
    yin = string('第')+string(num2str(i))+string('个音 ')...
        +string('拍数:')+string(num2str(jiepai(i))) + ' ';
    msg = [msg;yin;print_music_msg(A)];
    
if(A(4,1) >= 174.61*0.98 & A(4,1) <= 329.63*1.02)
        %认为在需要的频率范围内
        n = round(log2(A(4,1)/174.61)*12+1)
        if(guitar_weight(n,1)==0)
            y = write_xiebo(A);
            guitar_weight(n,:) = [y,zeros(1,28-length(y))];
        end
end
    
end

file = fopen('msg.txt','w+');
fprintf(file,'%s',msg);
 
