
% 先确定Xij的个数一共是2*6=12个
x0 = zeros(1,12);% 给Xij赋初始值
Aeq = [eye(6),eye(6)];% 线性等式的系数矩阵
beq = [5;9;4;8;14;11];% 线性等式的常数项
A = [ones(1,6),zeros(1,6);zeros(1,6),ones(1,6)];% 线性不等式的系数矩阵
b = [30;20];% 线性不等式的常数项
lb = zeros(1,12);
ub = repmat(Inf, 1, 12);
[x,val] = fmincon (@f3, x0, A, b, Aeq, beq, lb, ub, []);
