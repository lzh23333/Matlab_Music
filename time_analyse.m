function [jiepai,step_time] = time_analyse(delta_time,end_time,fs)
%输入每个冲激的时间加上最后一个乐音结束的时间(下标)
%输出jiepai为每个乐音的拍数
%step_time为单拍的时间
%直接选择中位数作为1拍
time = [delta_time,end_time];
diff_t = diff(time);
steps = round(diff_t/min(diff_t));%得出节拍数
single_step = median(diff_t);
step_time = single_step/fs;     %得出单拍的时间
index = find(diff_t == single_step);
jiepai = steps/steps(index(1));     %除于该单拍，得到其他乐音对应拍数
