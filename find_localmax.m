function index = find_localmax(signal,pace,threshold)
%找到冲激点对应的index序列
%pace为步调，代表每次循环时采用的数组长度
%threshold代表极值点阈值，若小于它的则不算（适用于signal>0情况)
L = length(signal); 
time = ceil(L/pace);            %循环步数
index = [];                     %对应的冲激点的坐标
max_set = [];                   %每一步最大值序列
max_index_set = [];             %对应的下标序列
this_max = 0;                   
this_max_index = 0;

%寻找每一步的最大值及其下标并加入数组中
for i = 1:time               
    if(i*pace > L)
        [this_max,this_max_index] = max(signal((i-1)*pace+1:L));
    else 
        [this_max,this_max_index] = max(signal((i-1)*pace+1:i*pace));
    end
    this_max_index = this_max_index + (i-1)*pace;
    max_set = [max_set,this_max];
    max_index_set = [max_index_set,this_max_index];
end


%通过遍历寻找点
real_point = [];
if(max_set(1) > max_set(2) & max_set(1)>threshold)
    real_point = [real_point,max_index_set(1)];
end

for i = 2:length(max_set)-1
    if(max_set(i)>max_set(i-1) & max_set(i)>max_set(i+1) &max_set(i)>threshold)
        real_point = [real_point,max_index_set(i)];
    end
end
if(max_set(end)>max_set(end-1) & max_set(end)>threshold)
    real_point = [real_point,max_index_set(end)];
end
%draw
%{
figure(223333);
plot(signal);
hold on;
scatter(real_point,signal(real_point),'*');
%}
index = real_point;
    
    
    
    
    
    
    
    
    