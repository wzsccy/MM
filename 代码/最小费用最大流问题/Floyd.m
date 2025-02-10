%% floyed算法
function [path, dis] = Floyd(gra)
n = size(gra);
dis = gra;
path = zeros(n);
for k  = 1 : n %这是跳板节点
    for i = 1 : n
        for j = 1 :n
            if (dis(i,k) + dis(k,j) < dis(i,j)) % 通过跳板发现了更短的路径，更新最短路径
                dis(i,j) = dis(i,k) + dis(k,j);
                path(i,j) = k;
            end
        end
    end
end
