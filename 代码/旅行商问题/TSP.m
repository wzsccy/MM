%% 用改良圈算法求解旅行商问题
A = [0 56 21 35;
     56 0 49 39;
     21 49 0 77;
     35 39 77 0;];

L = size(A,1);%返回向量第一维度的长度
c = [1 2 3 4 1];% 初始圈
for k = 1 : L
    flag = 0;% 修改标志
    for i = 1 : L-2  % i是第一条弧的起点
        for j = i + 2 : L % j是第二条弧的起点
            if( A(c(i),c(j)) + A(c(i+1),c(j+1)) < A(c(i),c(i+1)) + A(c(j),c(j+1)) )
                c(i+1:j) = c(j:-1:i+1);% 翻转中间的路径,j:-1:i+1表示从j到i+1，步长为-1
                flag = flag + 1;
            end
        end
    end
    if(flag == 0) %本轮没有找到2条更短的弧
        long = 0; %圈长
        for i = 1 : L
            long = long + A(c(i),c(i+1));
        end
    end
end