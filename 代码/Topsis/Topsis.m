%% 导入数据
%X=[99,0.010;100,0.012;98,0.040;97,0.033];
X=xlsread('D:\BaiduNetdiskDownload\第5讲 Topsis\代码\工作簿1.xlsx');
X=X(:,[2:5]);

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

%% （法一）用距离法打分
disp('用距离法打分')
max_x=max(stand_x,[],1);
min_x=min(stand_x,[],1);

(stand_x-repmat(min_x,n,1))./(max_x-min_x)

%% 用优劣解打分
disp('用优劣解打分')
tmp=ones(m);%生成m行m列的1矩阵
w_j=tmp(:,1);%取出第一列
is_need_w=input('是否需要指定权值，如果需要请输入1，否则输入0:\n');
if(is_need_w==1)
    w_j=input('请按列输入各指标权值，（如[0.1，0.2，0.3，0.4]）');
end
z_plus=repmat(max_x,n,1);
z_sub=repmat(min_x,n,1);
D_plus=sum(((stand_x-z_plus).^2)*w_j,2).^0.5;
D_sub=sum(((stand_x-z_sub).^2)*w_j,2).^0.5;

S=D_sub./(D_sub+D_plus);

%将结果归一化
res_topsis=S./sum(S);

%将结果放入excel表中
xlswrite('res_Topsis',res_topsis)









