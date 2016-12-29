clc; close all;clear all;
A = 1;
f = 0.06;
phi = pi/4;
v1 = 0.05;
v2 = 0.1;
v3 = 1;
N = 10:1:100;
M=1000;
%% (g)
err1=zeros(90,1);
for i=10:1:100
    tx1=[];
    tx2=[];
    tx3=[];
    fx1=[];
    fx2=[];
    tx=[];
    phi_by_formula1=zeros(M,1);
    phi_by_formula2=zeros(M,1);
    phi_by_formula3=zeros(M,1);
    for k=1:i
        fx1=[fx1;sin(2*pi*f*k)];
        fx2=[fx2;cos(2*pi*f*k)];
        tx=[tx;cos(2*pi*f*k+phi)];
    end
    for j=1:M
        t_x1=A*tx+normrnd(0,sqrt(v1),i,1);
        phi_by_formula1(j) = -atan((t_x1'*fx1)/(t_x1'*fx2));
        t_x2=A*tx+normrnd(0,sqrt(v2),i,1);
        phi_by_formula2(j) = -atan((t_x2'*fx1)/(t_x2'*fx2));
        t_x3=A*tx+normrnd(0,sqrt(v3),i,1);
        phi_by_formula3(j) = -atan((t_x3'*fx1)/(t_x3'*fx2));
    end
    err1(i-9) = sum((phi_by_formula1-phi).^2)/M;
    err2(i-9) = sum((phi_by_formula2-phi).^2)/M;
    err3(i-9) = sum((phi_by_formula3-phi).^2)/M;
end
figure;
plot(10:1:100,err1);
xlabel('N');ylabel('error');
title('A=1, var=0.05');
figure;
plot(10:1:100,err2);
xlabel('N');ylabel('error');
title('A=1, var=0.1');
figure;
plot(10:1:100,err3);
xlabel('N');ylabel('error');
title('A=1, var=1');

figure;
plot(10:1:100,err1,'g');
hold on;
plot(10:1:100,err2,'r');
hold on;
plot(10:1:100,err3,'b');
xlabel('N');ylabel('error');
title('A=1, var=0.05, 0.1, 1');
legend('var=0.05','var=0.1','var=1');