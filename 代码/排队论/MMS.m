s = input('请输入服务台数量 s（例如 2）: ');
lambda = input('请输入顾客到达率 λ（例如 3）: ');
mu = input('请输入服务率 μ（例如 4）: ');

%% 理论计算
ro = lambda / mu;
ros = ro / s;

% 计算 p0（系统中0个顾客的概率）
sum1 = 0;
for i = 0:(s-1)
    sum1 = sum1 + (ro^i) / factorial(i);
end
sum2 = (ro^s) / factorial(s) / (1 - ros);
p0 = 1 / (sum1 + sum2);

% 计算其他指标
p = (ro^s) * p0 / factorial(s) / (1 - ros);
Lq = p * ros / (1 - ros);  % 平均队列长度
L = Lq + ro;               % 系统中平均人数
W = L / lambda;            % 平均逗留时间
Wq = Lq / lambda;          % 平均等待时间

% 显示理论结果
fprintf('\n===== 理论计算结果 =====\n');
fprintf('系统利用率: %.2f%%\n', ros * 100);
fprintf('平均队列长度 Lq: %.2f 人\n', Lq);
fprintf('系统中平均人数 L: %.2f 人\n', L);
fprintf('平均逗留时间 W: %.2f 分钟\n', W * 60);
fprintf('平均等待时间 Wq: %.2f 分钟\n', Wq * 60);

%% 仿真
sim_time = 100;  % 仿真时间（分钟）
t = 0;
event_list = [];  % 事件列表：[时间, 类型] 0=到达, 1=离开
queue = [];       % 等待队列
servers = zeros(1, s);  % 每个服务台的结束时间
arrival_times = [];
wait_times = [];
stay_times = [];

% 初始到达事件
next_arrival = exprnd(1/lambda * 60);  % 转换为分钟
event_list = [next_arrival, 0];

while t < sim_time
    [~, idx] = min(event_list(:,1));
    event = event_list(idx,:);
    event_list(idx,:) = [];
    t = event(1);

    if event(2) == 0  % 到达事件
        arrival_time = t;
        arrival_times = [arrival_times, arrival_time];
        [~, free_server] = min(servers);
        if servers(free_server) <= t
            service_time = exprnd(1/mu * 60);
            servers(free_server) = t + service_time;
            wait_time = 0;
            departure_time = servers(free_server);
            wait_times = [wait_times, wait_time];
            stay_times = [stay_times, departure_time - arrival_time];
            event_list = [event_list; departure_time, 1];
        else
            queue = [queue; arrival_time];
        end
        next_arrival = t + exprnd(1/lambda * 60);
        event_list = [event_list; next_arrival, 0];
    else  % 离开事件
        if ~isempty(queue)
            arrival_time = queue(1);
            queue(1) = [];
            wait_time = t - arrival_time;
            service_time = exprnd(1/mu * 60);
            departure_time = t + service_time;
            servers(free_server) = departure_time;
            wait_times = [wait_times, wait_time];
            stay_times = [stay_times, departure_time - arrival_time];
            event_list = [event_list; departure_time, 1];
        end
    end
end

% 绘图：到达与离开时间
figure;
plot(arrival_times, 'b.-', 'DisplayName', '到达时间');
hold on;
plot(arrival_times + stay_times, 'r.-', 'DisplayName', '离开时间');
xlabel('顾客编号');
ylabel('时间（分钟）');
title('顾客到达与离开时间（纵轴距离 = 等待时间）');
legend;
grid on;