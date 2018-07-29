function energy = calc_energy(signal,step)
%近似计算每step步中的能量
L = length(signal);
energy = 0*signal;          
time = ceil(L/step);      %计算次数
for i = 1:time
    if(i*step < L)
        sum_e = sum(signal((i-1)*step+1:i*step).^2);
        energy((i-1)*step+1:i*step) = sum_e * ones(1,step);
    else
        sum_e = sum(signal((i-1)*step+1:L).^2);
        energy((i-1)*step+1:L) = sum_e * ones(1,L-(i-1)*step);
    end
end
%draw
%{
figure(100);
subplot(1,2,1);
plot(signal);
title('signal');
subplot(1,2,2);
plot(energy);
title(['energy in ',num2str(step),' steps']);
%}

