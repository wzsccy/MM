%% 黄河小浪底调水调沙问题
%save('water.mat','water')
load('water.mat')
load('sand.mat')
t = [];
for i = 1 : 24
    t = [t 3600*(12*i - 4)];   
end

total_sand = sand .* water; %排沙量

pp = spline(t,total_sand); %返回三次样条插值结果
f = @(t) ppval(pp,t);% 定义了一个匿名函数f，该函数使用ppval函数计算分段多项式的值。
                     % 这个匿名函数可以作为被积函数传递给MATLAB的integral函数，从而计算分段多项式的积分。

q = integral(f,t(1),t(24));% 被积函数、积分上下限

% 绘图看一看
subplot(1,2,1)%将图分成左右两个板块，第三个参数是选择哪个板块，这里是第一个板块
plot(water(1:11),total_sand(1:11),'*')
xlabel('水流量');
ylabel('排沙量');
title('第一阶段')
subplot(1,2,2)%同理，这里是第二个板块
plot(water(12:24),total_sand(12:24),'*')
xlabel('水流量');
ylabel('排沙量');
title('第二阶段');

% 拟合
x1 = water(1:11);
y1 = total_sand(1:11);
x2 = water(12:24);
y2 = total_sand(12:24);