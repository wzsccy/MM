lambda = input('请输入到达率 λ（单位：人/小时）: ');
mu = input('请输入服务率 μ（单位：人/小时）: ');

%% 理论计算
rho = lambda / mu;  % 系统利用率
Lq = rho^2 / (1 - rho);  % 平均队列长度
L = rho / (1 - rho);     % 系统中平均人数
Wq = Lq / lambda;        % 平均等待时间（小时）
W = L / lambda;          % 平均逗留时间（小时）

fprintf('系统利用率 ρ = %.2f\n', rho);
fprintf('平均队列长度 Lq = %.2f 人\n', Lq);
fprintf('系统中平均人数 L = %.2f 人\n', L);
fprintf('平均等待时间 Wq = %.2f 分钟\n', Wq * 60);
fprintf('平均逗留时间 W = %.2f 分钟\n', W * 60);

%% 仿真部分
sim_time = 100;  % 仿真时间（小时）
t = 0;
event_list = [];  % 事件列表：[时间, 类型] 0=到达, 1=离开
queue = [];       % 等待队列
server = 0;       % 服务台状态（结束时间）
arrival_times = [];
wait_times = [];
stay_times = [];

% 初始到达事件
next_arrival = exprnd(1/lambda);
event_list = [next_arrival, 0];

while t < sim_time
    [~, idx] = min(event_list(:,1));
    event = event_list(idx,:);
    event_list(idx,:) = [];
    t = event(1);

    if event(2) == 0  % 到达事件
        arrival_time = t;
        arrival_times = [arrival_times, arrival_time];
        if server <= t
            % 立即服务
            service_time = exprnd(1/mu);
            server = t + service_time;
            wait_time = 0;
            departure_time = server;
            wait_times = [wait_times, wait_time];
            stay_times = [stay_times, departure_time - arrival_time];
            event_list = [event_list; departure_time, 1];
        else
            % 加入队列
            queue = [queue; arrival_time];
        end
        % 安排下一个到达
        next_arrival = t + exprnd(1/lambda);
        event_list = [event_list; next_arrival, 0];
    else  % 离开事件
        if ~isempty(queue)
            arrival_time = queue(1);
            queue(1) = [];
            wait_time = t - arrival_time;
            service_time = exprnd(1/mu);
            departure_time = t + service_time;
            server = departure_time;
            wait_times = [wait_times, wait_time];
            stay_times = [stay_times, departure_time - arrival_time];
            event_list = [event_list; departure_time, 1];
        end
    end
end

%% 绘图展示
figure;

% 图1：到达时间与离开时间
subplot(2,1,1);
n_served = length(stay_times);
plot(arrival_times(1:n_served), 'b.-', 'DisplayName', '到达时间');
hold on;
plot(arrival_times(1:n_served) + stay_times, 'r.-', 'DisplayName', '离开时间');
xlabel('顾客编号');
ylabel('时间（小时）');
title('顾客到达与离开时间');
legend;
grid on;

% 图2：等待时间与停留时间
subplot(2,1,2);
plot(wait_times, 'g.-', 'DisplayName', '等待时间');
hold on;
plot(stay_times, 'm.-', 'DisplayName', '停留时间');
xlabel('顾客编号');
ylabel('时间（小时）');
title('顾客等待时间与停留时间');
legend;


