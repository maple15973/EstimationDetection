clc; close all;
A = 1;
f = 0.06;
phi = pi/4;
v = 0.05;
N = 100;
x=[];k=[];
for i=1:N
    x=[x;A*cos(2*pi*f*i+phi)+normrnd(0,sqrt(v))];
end
%% (b) grid search
step_size= pi/10000;
grid_search = [];
for i= -pi:step_size:pi
    tx=[];
    for j=1:N
        tx=[tx;A*cos(2*pi*f*j+i)];
    end
    loglkh = -N/2 * log(2*pi*v) - 1/(2*v) * (sum((x-tx).^2));
    grid_search = [grid_search;loglkh];
end
[value,index]=max(grid_search);
phi_gird= -pi+ (index-1)*step_size;
figure;
plot(-pi:step_size:pi,grid_search);
hold on;
plot([phi_gird phi_gird],[-2500 500]);
xlabel('-pi : pi/10000 : pi');ylabel('loglikelihood');

%% (d)
dev = 100;
err=[];
count=0;
phi_s=0;
while dev>0.01
    count=count+1;
    tx1=[];
    tx2=[];
    for j=1:N
        tx1=[tx1;sin(2*pi*f*j+phi_s)];
        tx2=[tx2;sin(4*pi*f*j+2*phi_s)];
    end
    dev = -A/v * (sum(x.*tx1)-sum(A/2*tx2));
    I = N*A^2 /(2*v) ;
    phi_s = phi_s + inv(I) *dev;
    err=[err;dev-phi];
end
figure;
plot(1:1:length(err),err);
xlabel('iteration_index');ylabel('phase_error');
%% (e)
M=1000;
phi_m_s=zeros(M,1);
phi_by_formula=zeros(M,1);
I_inv = (2*v)/(N*A^2);
for i=1:M
    dev=10;
    t_x=[];
    for j=1:N
        t_x=[t_x;A*cos(2*pi*f*j+phi)+normrnd(0,sqrt(v))];
    end
    while dev>0.001
        tx1=[];
        tx2=[];
        for j=1:N
            tx1=[tx1;sin(2*pi*f*j+phi_m_s(i))];
            tx2=[tx2;sin(4*pi*f*j+2*phi_m_s(i))];
        end
        dev = -A/v * ((t_x'*tx1)-sum(A/2*tx2));
        phi_m_s(i) = phi_m_s(i) + I_inv *dev;
    end
    fx1=[];
    fx2=[];
    for j=1:N
        fx1=[fx1;sin(2*pi*f*j)];
        fx2=[fx2;cos(2*pi*f*j)];
    end
    phi_by_formula(i) = -atan((t_x'*fx1)/(t_x'*fx2));
end
mean_phi=mean(phi_by_formula);
var_phi=var(phi_by_formula);
vari=sqrt(2*v/N);
norm = normpdf(0.65:0.01:0.95,phi,vari);
pd = fitdist(phi_by_formula,'Normal');
y = pdf(pd,0.65:0.01:0.95);
figure;
yyaxis left
histogram(phi_m_s);
yyaxis right
hold on;
plot(0.65:0.01:0.95,norm,'LineWidth',2);