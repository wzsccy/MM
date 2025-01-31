%% 中间型转极大型，传入参数为待正向化向量，返回为正向化后的结果
function [res]= Mid2Max(X,best)
    M=max(abs(X-best));
    res=1-abs(X-best)/M;
end

