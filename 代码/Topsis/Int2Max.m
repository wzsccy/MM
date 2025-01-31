%% 区间型转极大型，传入参数为待正向化向量，返回为正向化后的结果
function [res] = Int2Max(X,a,b)
    M=max(a-min(X),max(X)-b);
    for i=1:size(X)
        if(X(i)<a)
            X(i)=1-(a-X(i))/M;
        elseif(X(i)>=a&&X(i)<=b)
            X(i)=1;
        elseif(X(i)>b)
            X(i)=1-(X(i)-b)/M;
        end
    end
    res=X;

end

