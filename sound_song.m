function song = sound_song(music_tone,music_time,one_step,fs,basic_f,method)
song = fourier_song_creation(music_tone,music_time,one_step,fs,basic_f,method);
sound(song,fs);
plot(song);
title('song');