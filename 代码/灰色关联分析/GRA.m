%% 导入数据
X=xlsread('D:\BaiduNetdiskDownload\第6讲 灰色关联分析\代码\data.xlsx');

%% 正向化
disp("正在进行正向化")
vec=input('请输入正向化向量组，以数组的形式输入，如[1,2,3]表示1，2，3列需要正向化，不需要正向化请输入-1\n');
if(vec~=-1)
    for i=1:size(vec,2)
        flag=input(['第' num2str(vec(i)) '是那类数据（1.极小型，2.中间型，3.区间型，请输入序号：\n）']);
        if (flag==1)
            X(:,vec(i))=Min2Max( X(:,vec(i)));
        elseif (flag==2)
            best=input('请输入中间值的最好值:\n');
            temp=X(:,vec(i));
            X(:,vec(i))=Mid2Max(X(:,vec(i)),best);
        elseif (flag==3)
            arr=input('请输入最佳区间，按照[a,b]的形式输入:\n');
            X(:,vec(i))=Int2Max(X(:,vec(i)),arr(1),arr(2));
        end
    end
    disp("所有数据都已经正向化完成")
end

%% 标准化
disp("正在进行标准化");
[n,m]=size(X);
%先检查有没有负元素
isNeg=0;
for i=1:n
    for j=1:m
        if(X(i,j)<0)
            isNeg=1;
            break;
        end
    end
end
if(isNeg==0)
    squere_x=(X.*X);%平方
    sum_x=sum(squere_x,1).^0.5;%按列求和，在开方
    stand_x=X./repmat(sum_x,n,1);%得到标准化后的结果
else
    max_x=max(X,[],1);%按列找出最大元素
    min_x=min(X,[],1);%按列找出最小元素
    stand_x=X-repmat(min_x,n,1)./(repmat(max_x,n,1)-repmat(min_x,n,1));
end

%% 灰色关联度分析
res=stand_x;
GRE_X=[res,max(res,[],2)];%按行寻找最大数；注意这里我们把x0放到了最后一列
[m,n]=size(GRE_X);
gamma_X=zeros(m,n-1);
for i=1:n-1
    gamma_X(:,i)=abs(GRE_X(:,i)-GRE_X(:,n));
end
b=max(max(gamma_X));
a=min(min(gamma_X));
roh=0.5;
gamma_X=(a+roh*b)./(gamma_X+roh*b);
gre_res=sum(gamma_X)./m;
















