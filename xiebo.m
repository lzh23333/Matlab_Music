function y = xiebo(basic_f,t,begin_time,weight)
%basic_f为基频
%t为对应时间序列
%begin_time为该段乐音开始的时间
%weight为谐波权重

y = 0*t;
if(basic_f~=0)
    while(basic_f<174.61*0.98)
        basic_f = basic_f*2;
    end
    while(basic_f>349.23*1.02)
        basic_f = basic_f/2;
    end
    %防止basic_f在外面的范围

    n = round(log2(basic_f/174.61)*12+1);         %求对应的位置
    if(n<1 | n > 12)
        n = mod(n,12);
    end

    [r,c] = size(weight);

    for i = 1:c
        if(weight(n,i)~=0)
            y = y + weight(n,i)*sin(2*pi*i*basic_f*(t-begin_time));
        end
    end
end