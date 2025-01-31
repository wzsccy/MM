%% 用蒙特卡洛解决建校问题
n=10000;%设置模拟次数
res_min=+Inf;
res_x=0;
for i=1:n
    x=randi([0,1],6,1);%生成一个6*1的0或1向量
    if(x(1)+x(2)+x(3)>=1&x(4)+x(6)>=1&x(3)+x(5)>=1&x(2)+x(4)>=1&x(5)+x(6)>=1&x(1)>=1&x(2)+x(4)+x(6)>=1)
        sum_x=sum(x);
        if(sum_x<res_min)
            res_x=x;
            res_min=sum_x;
        end
    end
end

%% 用蒙特卡洛解决工厂分配设备问题
n=10000;%设置模拟次数
c=[4,2,3,4;
    6,4,5,5;
    7,6,7,5;
    7,8,8,6;
    7,9,8,6;
    7,10,8,6];
res_x=0;
res=0;
for k=1:n
    flag=1;
    x=randi([1,4],1,6);%生成一个1*6的向量，元素为1~4的整数，表示该设备分配给了哪个企业
    for j=1:4%检查每个企业至少分配一台
        if(ismember(j,x)==0) %ismember(j,x)表示x向量中是否有j这个元素，有返回1，没有返回0
            flag=0;
            break;
        end
    end

    if (flag==1)
        sum=0;
        for j=1:6
            sum=sum+c(j,x(j));
        end
        if(sum>res)
            res=sum;
            res_x=x;
        end
    end
end

%% 蒙特卡洛模拟
a=10;%木纹间距
L=5;%表示针的长度
n=100000;%投掷次数
ph=rand(n,1)*pi;%随机抛针，得到角度
x=rand(n,1)*a/2;%针的中心到最近木纹的距离
m=0;%表示相交的次数
y=(L/2)*sin(ph);%恰好相交边界的情况
axis=([0,pi,0,a/2]);%先设置坐标轴
box on;%让图hold住不要动，否则会绘制一张新图
for i=1:n
    if(x(i)<=y(i))
        m=m+1;
        plot(ph(i),x(i),'b.');
        hold on
    end
end
P=m/n;
mypi=2*L/(P*a);

%% 解决张麻子问题
n=10000;%设置模拟次数
x1=round(1+rand(n,1)*5);%round是4舍5入取整的函数
x2=randi([1,6],n,1);
res_x1=0;
res_x2=0;
max_y=0;
for i=1:n
    if(x1(i)+x2(i)<=6)
        if(240*x1(i)+120*x2(i)<=1200)
            if(40*x1(i)+30*x2(i)>max_y)
                max_y=40*x1(i)+30*x2(i);
                res_x1=x1(i);
                res_x2=x2(i);
            end
        end
    end
end


















































