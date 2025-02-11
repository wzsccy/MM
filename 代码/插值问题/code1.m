%% 一维插值问题
x = 1:10;
y = log(x); %lnx
plot(x,y,'o') % 描点作图
hold on;
new_x = 0.01:0.1:10;
p = pchip(x,y,new_x); % 三次埃尔米特插值法
plot(new_x,p)
hold on;
p = spline(x,y,new_x);% 三次样条插值
plot(new_x,p,'b-')
legend('样本点', '三次埃尔米特插值', '三次样条插值', 'Location', 'SouthEast');