%% 绘制数字标号的图
s=[1 2 3];%s为起始点，注意标号要从1开始，不能从0开始
t=[4 1 2]; %t为尾节点
w=[5 2 6];%w为权重，意思为1到4的权重为5；2到1的权重为2；3到2的权重为6
%绘制到权重的图
G=graph(s,t,w);
plot(G,'EdgeLabel',G.Edges.Weight,'LineWidth',2);
%绘制不带权重的图
%G2=graph(s,t);
%plot(G2,"LineWidth",2);
set(gca,'XTick',[],'YTick',[]);%去掉坐标轴上的数字

%% 绘制字符串标号的图
s={'北京','上海','广州','深圳','上海'};%定义元胞数组
t={'上海','广州','深圳','北京','深圳'};
w=[10 65 3 90 60];
G=graph(s,t,w);
plot(G,'EdgeLabel',G.Edges.Weight,'LineWidth',2);
set(gca,'XTick',[],'YTick',[]);

%% 重点绘制邻接矩阵的图
c = [0 15 10 20 0 0 0 0;
     0 0 0 0 7 10 0 0;
     0 0 0 0 0 8 2 0;
     0 0 0 0 0 0 18 0;
     0 0 0 0 0 0 0 6;
     0 0 0 0 0 0 0 16;
     0 0 0 0 0 0 0 20;
     0 0 0 0 0 0 0 0];

%view(biograph(c, [], 'ShowWeights', 'on'));%   biograph在新版matlab中被移除了

% 创建有向图
G = digraph(c);

% 自动生成节点名称
nodeNames = strcat('Node ', string((1:size(c, 1))));

% 绘制图
figure;
p = plot(G, 'Layout', 'layered', 'EdgeLabel', G.Edges.Weight);

% 设置节点名称
p.NodeLabel = nodeNames;

% 设置节点和边的样式
p.NodeColor = 'yellow'; % 设置节点颜色为黄色
p.EdgeColor = 'black'; % 设置边颜色为黑色
p.MarkerSize = 10; % 设置节点大小
p.NodeFontSize = 12; % 设置节点字体大小
p.EdgeFontSize = 10; % 设置边字体大小
p.LineWidth = 1.5; % 设置边线宽度

% 计算最短路径
% 假设我们要找到从节点1到节点8的最短路径
[startNode, endNode] = deal(1, 8);
[path, pathLength] = shortestpath(G, startNode, endNode);

% 显示最短路径
disp(['Shortest path from node ' num2str(startNode) ' to node ' num2str(endNode) ':']);
disp(path);
disp(['Path length: ' num2str(pathLength)]);

% 突出显示最短路径
highlight(p, path, 'EdgeColor', 'r', 'MarkerSize', 12, 'LineWidth', 2);




































