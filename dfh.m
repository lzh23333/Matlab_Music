%演奏任意格式的音乐
%请先将乐音曲调、持续拍数存入
%song_tone.mat,last_time.mat中
load dfh_song_tone.mat
load dfh_last_time.mat

fs = 8000;
one_step = 0.75;                         %单节拍时间 
basic_f = 174.61;                       %歌曲基调为F调

song = fourier_song_creation(dfh_song_tone,dfh_last_time,one_step,fs,basic_f,2);
sound(song,fs);
plot(song);
title('东方红');