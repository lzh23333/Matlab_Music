A = 1;
fs = 8000;
song_t = 4;                             %歌曲持续时间
t = linspace(0,song_t,song_t*fs);       %创建时间序列
song = 0 * t;
one_step = 0.5;                         %一个节拍所需时间    
basic_f = 349.23;                       %歌曲基调频率

song_tone = [5,5,6,2,1,1,6,2];  %[1,2,3,4,5,6,7,8]        %乐音序列
last_time = [1,0.5,0.5,2,1,0.5,0.5,2];%[1,1,1,1,1,1,1,1];%  %乐音对应持续时间序列
music_nums = length(song_tone);          %乐音个数

begin_time = 0;                         %每个乐音开始的时间
for i = 1:music_nums
    f = calc_f(song_tone(i),basic_f)
    range = (t>=begin_time & t<begin_time+last_time(i)*one_step);           %创建对应时间为1的逻辑数组
    song = song +  range * A .* sin( 2*pi*f.*(t-begin_time));               
    begin_time = begin_time + last_time(i)*one_step;
end

sound(song,fs);
