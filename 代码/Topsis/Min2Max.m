%% 极小型转极大型，传入参数为待正向化向量，返回为正向化后的结果
function [res] = Min2Max(X)
res=max(X)-X;
end

