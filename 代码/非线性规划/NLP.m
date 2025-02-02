%% 第一个例子讲解
x0=[0 0 0];
A=[-1,1,-1];
b=[0];
[x,val]=fmincon(@f1,x0,A,b,[],[],[],[],@nonlfun1);

%% 第二个例子讲解
x0=[0 0 0];
A=[-1,1,-1];
b=[0];
Aeq=[1,-1,0];
beq=[10];
lb=[10;-Inf;-Inf];
ub=[20;+Inf;+Inf];
[x,val]=fmincon(@f2,x0,A,b,Aeq,beq,lb,ub,@nonlfun2);
val=-val;