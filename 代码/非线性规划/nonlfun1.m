

function [c,ceq] = nonlfun1(x)
    % c表示非线性不等式约束
    c = [x(1) + x(2)^2 + x(3)^2 - 20];
    ceq = [-x(1) - x(2)^2 + 2];
    % ceq表示非线性等式约束
end
