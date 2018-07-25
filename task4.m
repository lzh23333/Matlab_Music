%加入谐波
fs = 8000;
song_t = 4;                             %歌曲时间
t = linspace(0,song_t,song_t*fs);       %时间序列
song = 0 * t;
one_step = 0.5;                         %单节拍时间    
basic_f = 349.23;                       %歌曲基调频率

song_tone = [5,5,6,2,1,1,6,2];  %[1,2,3,4,5,6,7,8]        %乐音序列
last_time = [1,0.5,0.5,2,1,0.5,0.5,2];%[1,1,1,1,1,1,1,1];%  %对应持续节拍序列


song = song_creation2(song_tone,last_time,one_step,fs,basic_f,4);%创作歌曲（加入谐波版）
song = song/max(song);
plot(song);
sound(song,fs);
