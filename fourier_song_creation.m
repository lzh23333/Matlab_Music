function song = fourier_song_creation(song_tone, lasting_time, one_step, fs, basic_f, method)
%输入乐音序列及对应持续时间、基调、采样频率等，生成歌曲信号song
%song_tone乐音序列
%lasting_time对应持续时间
%one_step单节拍时间
%basic_f歌曲基调
%method乐音包络方法，同时包括谐波分量方法

t_max = sum(lasting_time * one_step);
t = linspace(0,t_max,t_max*fs);             %时间序列
song = 0 * t;
begin_time = 0;
end_mul = 1.15;                                %拓宽乐音持续时间产生重叠

load('guitar_weight_final.mat');
weight = guitar_weight;
weight(:,9:28)=0;
for i = 1:length(song_tone)
    if(song_tone(i)==0)
        begin_time = begin_time + lasting_time(i)*one_step;                        %更新下一个乐音开始的时间
        continue;
    end
    
    f = calc_f2(song_tone(i),basic_f);
    
    end_time = begin_time+lasting_time(i)*one_step*end_mul;
    if(i < length(song_tone))
        if(song_tone(i+1) == 0)
            end_time = end_time + lasting_time(i+1)*one_step*end_mul;
        end
    end
    range = (t>=begin_time & t<end_time);   %生成对应时间范围内的矩形波
    %找到起始与终止的位置
    start_index = 1;
    end_index = 1;
    for k = 1:length(range)
        if(range(k)==1)
            start_index=k;
            break;
        end
    end
    for k = start_index:length(range)
        if(range(k)==0)
            end_index = k;
            break
        end
    end
    if(end_index == 1)end_index = length(range);end
   
    range_song = range(start_index:end_index) .* xiebo(f,t(start_index:end_index),begin_time,weight);
    
    %plot(range_song);
    %hold on;
   
    range_song1 = A_adjust(range_song,t(start_index:end_index),begin_time,end_time,method);    %调幅
    %plot(range_song1);
    
    
    song(start_index:end_index) = song(start_index:end_index) + range_song1;                                               %叠加
    begin_time = begin_time + lasting_time(i)*one_step;                        %更新下一个乐音开始的时间
    plot(song);
    if(any(isnan(song)))
        disp('find exception!');
    end
    %plot(t(range),song(range));
    %pause;
end
song = song/max(song);
