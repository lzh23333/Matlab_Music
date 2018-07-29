function f = calc_f2(tone,basic_f)
%计算f
%输入tone为简谱音调
%basic_f为基调
%算出的f会转为174.61——329.63Hz范围内的基频
if(tone==0)
    f=0;
else
    multiply = [0,2,4,5,7,9,11,12];
    f = basic_f * (2^(multiply(tone)/12));
    while(f<174.61*0.98)
        f = f*2;
    end
    while(f>349.23*1.02)
        f = f/2;
    end
end
