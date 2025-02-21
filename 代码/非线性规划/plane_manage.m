
clear;clc
x0 = [0 0 0 0 0 0];  %设定初始值
lb = -pi/6*ones(6,1); %下界
ub = pi/6*ones(6,1); %上界
[x,fval] = fmincon(@f4,x0,[],[],[],[],lb,ub,@nonlfun4); %注意这里我们是用弧度制 
%% 一些绘图tips
% 我们可以把每次调整后的飞机位置在图中标记上
clear;clc
data = [150	140	243;
    85	85	236;
    150	155	220.5;
    145	50	159;
    130	150	230;
    0	0	52];
plot(data(:,1),data(:,2),'.r')
axis([0 160,0,160]);% 设置坐标轴刻度范围
hold on;
for i = 1:6
    txt = ['飞机',num2str(i)];
    text(data(i,1)+2,data(i,2)+2,txt,'FontSize',8)
end
for i = 1 : 20
    plot(data(:,1),data(:,2),'.r');
    hold on;
    x0 = [0 0 0 0 0 0];  %设定初始值
    lb = -pi/6*ones(6,1); %下界
    ub = pi/6*ones(6,1); %上界
    [x,fval] = fmincon(@f4,x0,[],[],[],[],lb,ub,@nonlfun4); %注意这里我们是用弧度制 
    theta = [243 236 220.5 159 230 52] * pi / 180;
    theta = theta + x;
    %%%%%%%%%%%=========注意这里我们把速度调小了，以方便观察，不要忘记修改nonlfun4里的速度=========%%%%%%%%%%%
    data(:,1) = data(:,1) + 8 * cos(theta)'; 
    data(:,2) = data(:,2) + 8 * sin(theta)';
end
% 最后一步就是把Matlab做出来的图可以导出，然后再放到PPT中画出飞机飞行方向的箭头（就和讲义上的类似）
