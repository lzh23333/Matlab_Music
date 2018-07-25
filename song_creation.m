function song = song_creation(song_tone, lasting_time, one_step, fs, basic_f, method)
%输入乐音序列及对应持续时间、基调、采样频率等，生成歌曲信号song
%song_tone乐音序列
%lasting_time对应持续时间
%one_step单节拍时间
%basic_f歌曲基调
%method乐音包络方法

t_max = sum(lasting_time * one_step);
t = linspace(0,t_max,t_max*fs);             %时间序列
song = 0 * t;
begin_time = 0;
end_mul = 1.05;                                %拓宽结束时间，产生音符的交叠


for i = 1:length(song_tone)
    f = calc_f(song_tone(i),basic_f);

    range = (t>=begin_time & t<begin_time+lasting_time(i)*one_step*end_mul);   %生成对应时间范围的矩形波
    range_song = range .* sin( 2*pi*f.*(t-begin_time));                     %乘正弦信号
    range_song1 = A_adjust(range_song,t,begin_time,lasting_time(i)*one_step*end_mul,method);    %调幅
    song = song + range_song1;                                               %叠加
    begin_time = begin_time + lasting_time(i)*one_step;                        %更新下一个乐音起始时间
end
