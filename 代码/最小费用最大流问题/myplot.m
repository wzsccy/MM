%% 绘制图片
function [] = myplot(gra)
    n = size(gra, 2);
    for i = 1:n
        for j = 1:n
            if gra(i, j) == Inf
                gra(i, j) = 0;
            end
        end
    end
    % 创建有向图对象
    G = digraph(gra);
    % 绘制图形并显示权重
    h = plot(G, 'EdgeLabel', G.Edges.Weight);
    % 设置图形布局
    layout(h, 'force'); % 使用力导向布局
end