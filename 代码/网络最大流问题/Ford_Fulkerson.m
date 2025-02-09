%% 用标号发求解网络最大流问题,注意由于版本问题graphmaxflow函数不能被调用
% 构建邻接矩阵
a = zeros(7);
a(1,2) = 4; a(1,4) = 3; a(1,5) = 10;
a(2,3) = 1; a(2,4) = 3; a(4,3) = 4;
a(5,4) = 3; a(4,6) = 5; a(5,6) = 4;
a(6,3) = 2; a(3,7) = 7; a(6,7) = 8;

% 将邻接矩阵转换为有向图对象
G = digraph(a);

% 绘制原图
figure;
plot(G, 'EdgeLabel', G.Edges.Weight); % 使用 plot 函数绘制图，并显示边权重
title('原图');

% 调用 maxflow 函数计算最大流
[MaxFlow, FlowMatrix, Cut] = maxflow(G, 1, 7); % Cut为最小割


% 提取 FlowMatrix 中的边信息
flow_edges = FlowMatrix.Edges; % 提取边信息
flow_weights = flow_edges.Weight; % 提取边权重
flow_sources = flow_edges.EndNodes(:, 1); % 提取源节点
flow_targets = flow_edges.EndNodes(:, 2); % 提取目标节点

% 创建流量图对象
G_flow = digraph(flow_sources, flow_targets, flow_weights);

% 绘制最大流图
figure;
p = plot(G_flow, 'EdgeLabel', G_flow.Edges.Weight); % 绘制最大流图，并显示边权重
title('最大流图');