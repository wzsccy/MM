goals = [1, -1;
         1, 2;
         8, 10];

A = [2, 1]; b = 11;
lb = zeros(2 + 2*3, 1);  % 2 个变量 + 6 个偏差变量
ub = [];
x0 = [1, 1, zeros(1, 6)];  % 初始值

nPriorities = 3;
x_opt = x0;

for priority = 1:nPriorities
    options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
    [x_opt, fval] = fmincon(@(x) goalprog_general(x, priority, goals, A, b, [], [], lb, ub), ...
                            x_opt, [], [], [], [], lb, ub, [], options);
    fprintf('优先级 %d 求解完成，目标函数值: %.4f\n', priority, fval);
end

fprintf('最优解：x1=%.4f, x2=%.4f\n', x_opt(1), x_opt(2));
