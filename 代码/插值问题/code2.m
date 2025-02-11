%% 二维插值问题
x = -1:0.5:1;
y = -1:0.5:1;
[x, y] = meshgrid(x, y); % 要先转成网格格式才能插值
z = 1 - x .^2 - y .^ 2;
new_x = -1:0.1:1;
new_y = -1:0.1:1;
[new_x, new_y] = meshgrid(new_x, new_y);
p = interp2(x, y, z, new_x, new_y, 'spline'); % 二维插值，用三次样条插值算法
mesh(new_x, new_y, p)% 绘图之前要确定参数均为网格格式