A = 1;
fs = 8000;
song_t = 4;                             %歌曲持续时间
t = linspace(0,song_t,song_t*fs);       %时间序列
song = 0 * t;
one_step = 0.5;                         %单节拍时间    
basic_f = 349.23;                       %歌曲基调频率

song_tone = [5,5,6,2,1,1,6,2];  %[1,2,3,4,5,6,7,8]        %歌曲乐音序列
last_time = [1,0.5,0.5,2,1,0.5,0.5,2];%[1,1,1,1,1,1,1,1];%  %对应持续时间序列

song = song_creation(song_tone,last_time,one_step,fs,basic_f,1);

%sound(song);     %正常速率播放
%sound(song,16000);  %2倍速播放，提高八度
%sound(song,4000);   %半速播放，降低八度
new_fs = 8000 * 1.0595; %新采样频率
[new_song,new_t] = resample(song,t,new_fs); %重新采样
new_t = new_t * 1.0595; %新时间序列
sound(new_song,8000);   %提高半音阶