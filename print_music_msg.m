function y = print_music_msg(A)
%将A中信息转为字符串,注意2016b以上版本可使用
[r,c] = size(A);
nums = r/4;
msg = string();

music_tone = {'A ';'Bb';'B ';'C ';'Db';'D ';'Eb';'E ';'F ';'Gb';'G ';'Ab'};
[r,c] = size(A);
for i = 1:nums
    msg(i,:) = '基波音调:'+string(music_tone(A(4*(i-1)+1,1)+1))+','+'频率:'+num2str(A(4*i,1))+'Hz; ',...
        +' 各次谐波: ';
    for time = 2:c
        if(A(4*(i-1)+2,c) ~= 0)
            msg(i,:) = msg(i,:)+num2str(A(4*(i-1)+2,time))+'次谐波 '+'频率'+num2str(A(4*i,time))+' 系数:'+num2str(A(4*(i-1)+3,time))+'; ';
        end
    end
end
%disp(msg);
y = msg+char(13)+char(10);