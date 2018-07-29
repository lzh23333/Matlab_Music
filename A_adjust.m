function f = A_adjust(f, t, begin_time, tone_time, method)
%对输入乐音段落进行调幅
%f代表输入的乐音
%t为对应时间序列
%tone_time为该乐音持续时间
%method为包络方法，1为线性包络（同课本），2为冲激加指数衰减包络，3为sin加上sigmoid调制的包络

t_max = t(length(t)) ;   
if(begin_time + tone_time > t_max)
    end_time = t_max ;
else 
    end_time = begin_time + tone_time;      
end
%确定结束时间

time = end_time - begin_time;                   %乐音持续时间
A_range = (t>=begin_time & t<end_time);         %确定该乐音对应的范围

if(method == 1)
    A_range =   (t>=begin_time & t<begin_time+time/6).*(6/time*(t-begin_time)) + ...
                (t>=begin_time+time/6 & t<begin_time+time/3).*(-1.2/time*(t-begin_time-time/6)+1) + ...
                (t>=begin_time+time/3 & t<begin_time+time*2/3).*(0.8) + ...
                (t>=end_time-time/3 & t<end_time).*(-2.4/time*(t-end_time));
    
elseif(method == 2)
    A_range =   (t>=begin_time & t<begin_time+time/20).*(20/time*(t-begin_time)) + ...
                (t>=begin_time+time/20 & t<end_time).* exp(-100/19/time*(t-begin_time-time/20)); 
elseif(method == 3)
    A_range =   (t>=begin_time & t<begin_time+time/3).*sin(3*pi/2/time*(t-begin_time)) + ...
                (t>=begin_time+time/3 & t<end_time).*(1./(1+exp(15/time*(t-begin_time-2/3*time)))+0.0067);
elseif(method == 4)
     A_range =   (t>=begin_time & t<begin_time+time/20).*(20/time*(t-begin_time)) + ...
         (t>=begin_time+time/20 & t<end_time).*(-20/19/time*(t-end_time));
elseif(method == 5)
      A_range =   (t>=begin_time & t<begin_time+time/20).*(20/time*(t-begin_time)) + ...
                (t>=begin_time+time/20 & t<end_time).* exp(-60/19/time*(t-begin_time-time/20)); 
end
plot(A_range);
f = f.*A_range;     %包络


    
    
    
    