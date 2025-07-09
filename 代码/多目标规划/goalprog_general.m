function [f, c, ceq] = goalprog_general(x, priority, goals, A, b, Aeq, beq, lb, ub)
    % 决策变量个数
    nvars = size(goals, 2);
    x_vars = x(1:nvars);           % [x1, x2]
    d_vars = x(nvars+1:end);       % [d1-, d2-, d3-, d1+, d2+, d3+]

    % 转置 x_vars，使得维度合法
    f_vals = goals * x_vars';      % 3×2 * 2×1 = 3×1

    % 偏差变量分拆
    ndev = length(d_vars) / 2;
    d_minus = d_vars(1:ndev);           % 负偏差
    d_plus = d_vars(ndev+1:end);        % 正偏差

    % 设置目标函数：根据优先级最小化对应目标的偏差
    switch priority
        case 1
            f = d_plus(1);         % 优先级1：最小化目标1的正偏差
        case 2
            f = d_minus(2);        % 优先级2：最小化目标2的负偏差
        case 3
            f = d_minus(3);        % 优先级3：最小化目标3的负偏差
        otherwise
            f = 0;
    end

    % 等式约束：f(x) + d- - d+ = 目标值（此处目标值设为 0）
    ceq = [
        f_vals(1) + d_minus(1) - d_plus(1);
        f_vals(2) + d_minus(2) - d_plus(2);
        f_vals(3) + d_minus(3) - d_plus(3);
    ];

    % 不等式约束
    c = A * x_vars' - b;

    % 逐级加锁：优先级已优化完成的偏差设为 0
    switch priority
        case 2
            ceq(end+1) = d_plus(1);      % 第一目标已完成，锁住 d1+
        case 3
            ceq(end+1) = d_plus(1);      % 锁 d1+
            ceq(end+1) = d_minus(2);     % 锁 d2-
    end
end
