# Matlab大作业——音乐合成实验报告

## 1、简单的合成音乐

### （1）

​	每个乐音的频率为：

| 1      | 2      | 3      | 4      | 5      | 6      | 7      | i      |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| 349.23 | 392.00 | 440.00 | 466.16 | 523.26 | 587.33 | 659.25 | 698.46 |

​	在MATLAB代码中，将简谱乐音表示为一个序列，且持续时间也为一个序列。通过自定义的calc_f函数计算出每个乐音对应的频率。定义歌曲序列song来表示由8000Hz采样频率采样下的歌曲。在每个乐音对应的时间区间内载入不同频率的正弦信号，从而合成出一段简单的音乐。

​	关键代码如下：

```
song_tone = [5,5,6,2,1,1,6,2];         	%歌曲乐音序列
last_time = [1,0.5,0.5,2,1,0.5,0.5,2]; %对应的每个乐音持续拍数
music_nums = length(song_tone);         %乐音数目

begin_time = 0;                         %每个乐音的开始时间
for i = 1:music_nums
    f = calc_f(song_tone(i),basic_f)
    range = (t>=begin_time & t<begin_time+last_time(i)*one_step);           %对应乐音所在的时间范围
    song = song +  range * A .* sin( 2*pi*f.*(t-begin_time));               %对应范围加载正弦信号
    begin_time = begin_time + last_time(i)*one_step;	
end

sound(song,fs);
```

​	音乐总体效果上，每个乐音间较不连续，且存在的’啪‘的杂音。降低要求来看，还是可以听出歌曲的调的。

### （2）

​	通过采用包络来修正乐音，且使得上一个乐音的衰减段与下一个乐音的冲激段相叠加，的确消除了相邻乐音间的杂音。在MATLAB代码中，乐音的正弦信号产生基本同（1），只是持续时间稍微延长至原来的1.1倍，使得相邻乐音间存在重叠。随后通过自定义函数A_adjust来对该乐音的幅度进行调整。采用了两种调幅方法：1.课本上的分段线性函数；2.一段冲激加上一段指数衰减的分段函数；分别定义为method1与method2.

​	设t0为该乐音起始演奏时间，time为持续时间，函数表达式如下：
$$
method1=\begin{cases}
\frac{6}{time}*(t-t0) ,& t0<=t<t+\frac{time}{6} \\
\frac{-1.2}{time}*(t-t0-\frac{time}{6})+1, &t0+\frac{time}{6}<=t<t0+\frac{time}{3}\\
0.8,&t0+time/3<=t<t0+\frac{2}{3}time\\
\frac{-2.4}{time}*(t-t0-time),&t0+\frac{2}{3}time<=t<t0+time
\end{cases}
$$

$$
method2=\begin{cases}
\frac{6}{time}*(t-t0) ,& t0<=t<t+\frac{time}{6} \\
exp(-\frac{18}{5time}*(t-t0-\frac{time}{6})) ,&t0+\frac{time}{6}<=t<t0+time
\end{cases}
$$
​	对应的东方红歌曲波形如下：

![method1](D:\github\Matlab_music\method1.png)![method2](D:\github\Matlab_music\method2.png)



### (3)

​	升高八度与降低八度，即将所有乐音对应的频率都进行乘2/除于2的操作。由于我制作的音乐信号为采样频率8000Hz的信号，故只需对其重新采样就行。所以只需在sound(song,fs)中将采样频率fs更改为16kHz/4kHz，即可实现升高/降低八度。

```
在命令行输入：
	sound(song,16000);
	sound(song,4000);
```

​	同样，要将音乐上升半个音阶，对应每个乐音的频率需乘(2^1/12)；故而只需使用resample函数，以8000*1.0595Hz采样即可，得到新音乐序列new_song。将new_song以默认频率播放，相当于原歌曲在时间上被拉长。

​	关键代码为：

```
new_fs = 8000 * 1.0595;				%新频率
[new_song,new_t] = resample(song,t,new_fs);	%以新的频率采样
sound(new_song,8000);			%在默认8000Hz下播放，相当于歌曲时间拉长
```

### （4）

​	通过在给每个乐音段赋值正弦函数时，加上2次、3次谐波分量，从而使得合成出的音乐有谐波分量。通过给不同谐波赋予不同权重来控制该分量的占比，从而可以产生不同的效果。同时，在权重上加入一个较小的随机数来使得乐音更加自然（产生了随机性）。

​	关键代码如下：	

```
weight = [1,0.3,0.1];                       %各谐波分量
range_song = range .* ( (weight(1)+0.005*rand(1))*sin( 2*pi*f.*(t-begin_time)) + (weight(2)+0.005*rand(1))*sin( 4*pi*f.*(t-begin_time)) +  (weight(3)+0.005*rand(1))*sin( 6*pi*f.*(t-begin_time)));                %加入随机数来模拟真实环境，该段范围内的音乐信号,加入谐波（未进行包络处理）
range_song1 = A_adjust(range_song,t,begin_time,lasting_time(i)*one_step*end_mul,method);    %包络处理
```

​	从音色上看的确比原有的单频乐音丰富了许多，类似于管弦乐器。在刚开始时未将音乐信号幅度归一化，导致出现杂音。归一化后音色正常，但与正常乐器相比仍有差距。

### （5）

​	我选择了Canon的一个较为简单的简谱进行合成。由于我的程序只需将简谱转为各个乐音对应的数字以及其持续的时间，即可进行合成。故而工作量只在于将简谱转换为程序所需的序列即可。

​	由于Canon歌曲有两个声道，故我合成了两个信号song与song2。将这两个信号进行加和后归一化，即可倾听美妙的Canon乐曲。

​	为了修改音色使得音乐有更好的效果，在包络上采取了更多的函数进行拟合，但总体效果上依旧和真实乐器有着较大差距。

​	关键代码如下：

```
song = song_creation2(song_tone,last_time,one_step,fs,basic_f,3);%生成音乐
song2 = song_creation2(song_tone2,last_time2,one_step,fs,basic_f,3);    %生成第二个声道的音乐
Canon_song = song + 0.3*song2;                      %两通道合成
Canon_song = Canon_song/max(Canon_song);            %限制幅度,归一化
sound(Canon_song);
```

​	通过手动输入音色与时间序列实在是非常麻烦，如果可以进一步尝试的话我偏向于采用图像识别分析简谱。













