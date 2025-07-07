% 定义目标函数
objectiveFcn = @(x) -x^2; % 由于 GA 默认是最小化，我们最小化 -x^2 来实现最大化 x^2

% 设置变量的上下界
lb = 0; % 下界
ub = 31; % 上界

% 设置遗传算法选项，包括绘制最佳适应度和适应度多样性的图形
options = optimoptions('ga', 'Display', 'iter', 'PlotFcn', {@gaplotbestf, @gaplotscorediversity});

% 调用遗传算法求解
[x, fval] = ga(objectiveFcn, 1, [], [], [], [], lb, ub, [], options);

% 输出结果
disp('最优解 x = ');
disp(x);
disp('最大值 y = x^2 = ');
disp(-fval); % 注意取反，因为我们最小化了 -x^2