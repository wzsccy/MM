%% 绘图
mat = xlsread('data1');
x = mat(:,1);%抽取第一列
y = mat(:,2);%抽取第二列
plot(x,y,'o')

%% 最小二乘法算k和b
n = size(x,1);%返回行数，第二个参数如果是2，返回列数
k = (n*sum(x.*y)-sum(x)*sum(y))/(n*sum(x.*x)-sum(x)*sum(x));
b = (sum(x.*x)*sum(y)-sum(x)*sum(x.*y))/(n*sum(x.*x)-sum(x)*sum(x));
hold on;

xx = 2.5:0.1:7;
yy = k*xx + b;
plot(xx,yy,'-');

%% 预测新冠肺炎确诊数
mat=xlsread("covid.xlsx");
day = mat(1,:);%抽取第一行
num=mat(2,:);
%通过matlab-app中的曲线拟合器进行拟合