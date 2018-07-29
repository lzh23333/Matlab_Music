function A = recgnize(music_f,music_A)
%处理频率列表，得到信息
%music_f为各声波频率
%music_A为对应幅度
%A每四行储存信息为（音调（0——11），对应几次谐波，谐波分量强度，频率值）

A = [];
base_f = [];                %存基调频率
for i = 1:length(music_f)
    if(music_f(i)==0)continue;end
    disp(num2str(i)+string('次迭代,频率为')+num2str(music_f(i))+string('Hz'));
    if(length(base_f)==0)   %第一次寻找
        base_f(1:2,1) = [music_f(i),music_A(i)];
        A(1:4,1) = [translate(music_f(i));1;1;music_f(i)];
        disp(string('第一次加入基波')+string(num2str(music_f(i))));
    else
       %先判断是否为基波的谐波分量
       is_mul = 0;      %判断是否谐波标志
       cor = 0;         %对应基波的index
       for k=1:length(base_f)
           sim = music_f(i)/base_f(k);
           if(abs(sim-round(sim)) < 0.1)%若计算出为谐波分量
               is_mul = 1;   
               cor = k;
               break;
           end
       end
       if(is_mul == 1)  %如果的确为谐波分量
           disp(string('谐波: 第')+num2str(i)+string('项'));
           [r,c] = size(A);
           write_col = 0;
           %确定写入A的第几列
           for j = 1:c
               if(A(4*(cor-1)+2,j) == 0)
                    write_col = j;
                    break;
               end
           end
           if(write_col == 0)
               write_col = c+1;
           end
           %写入信息
           %write_col
           A(4*cor-3:4*cor,write_col) = ...
               [translate(base_f(1,cor));...
               round(music_f(i)/base_f(cor));...
               music_A(i)/base_f(2,cor);...
               music_f(i)];
       else
           disp(string(num2str(music_f(i))) + string('为基波'));
           base_f(1:2,end+1) = [translate(music_f(i));music_A(i)];
           [r,c] = size(base_f);
            A(4*c+1:4*c+4,1) = [translate(music_f(i));1;1;music_f(i)];          
       end
    end
end

           