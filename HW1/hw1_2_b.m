clear all;close all;
%% (b)
N = 20;
theta = [0.5;-0.5;0.07;-0.005];
w = normrnd(0,0.1,N,1); % because variance is 0.01 ,so sigma is 0.1 
x = zeros(N,1);
H = zeros(N,5);
for i=0:N-1
    H(i+1,:)=[1,i,i^2,i^3,i^4];
    x(i+1)=[1,i,i^2,i^3]*theta+w(i+1);
end
temp=pinv(H'*H);
Est_theta = (H'*H)\H'*x;
CRLB = 0.01*[temp(1,1);temp(2,2);temp(3,3);temp(4,4);temp(5,5)];
%% (c)
N = 20;
M=1000;
Est_record=zeros(M,5);
for i=1:M
    theta = [0.5;-0.5;0.07;-0.005];
    w = normrnd(0,0.1,N,1); % because variance is 0.01 ,so sigma is 0.1 
    x = zeros(N,1);
    H = zeros(N,5);
    for j=0:N-1
        H(j+1,:)=[1,j,j^2,j^3,j^4];
        x(j+1)=[1,j,j^2,j^3]*theta+w(j+1);
    end
    Est_theta = pinv(H'*H)*H'*x;
    Est_record(i,:)=Est_theta';
end
Est_mean = mean(Est_record)';
Est_var = var(Est_record)';
temp=inv(H'*H);
CRLB = 0.01*[temp(1,1);temp(2,2);temp(3,3);temp(4,4);temp(5,5)];

%% (d)
N=100;
M=1000;
Est_record=zeros(M,5);
for i=1:M
    theta = [0.5;-0.5;0.07;-0.005];
    w = normrnd(0,0.1,N,1); % because variance is 0.01 ,so sigma is 0.1 
    x = zeros(N,1);
    H = zeros(N,5);
    for j=0:N-1
        H(j+1,:)=[1,j,j^2,j^3,j^4];
        x(j+1)=[1,j,j^2,j^3]*theta+w(j+1);
    end
    Est_theta = (H'*H)\H'*x;
    Est_record(i,:)=Est_theta';
end
Est_mean = mean(Est_record)';
Est_var = var(Est_record)';
temp=inv(H'*H);
CRLB = 0.01*[temp(1,1);temp(2,2);temp(3,3);temp(4,4);temp(5,5)];


%% (e)
Est_A=zeros(81,2);
Est_B=zeros(81,2);
Est_C=zeros(81,2);
Est_D=zeros(81,2);
Est_E=zeros(81,2);
Est_mean=zeros(81,5);
for N=20:100
    M=1000;
    Est_record=zeros(M,5);
    for i=1:M
        theta = [0.5;-0.5;0.07;-0.005];
        w = normrnd(0,0.1,N,1); % because variance is 0.01 ,so sigma is 0.1 
        x = zeros(N,1);
        H = zeros(N,5);
        for j=0:N-1
            H(j+1,:)=[1,j,j^2,j^3,j^4];
            x(j+1)=[1,j,j^2,j^3]*theta+w(j+1);
        end
        Est_theta = (H'*H)\H'*x;
        Est_record(i,:)=Est_theta';
    end
    Est_mean(N-19,:) = mean(Est_record);
    Est_var = var(Est_record)';
    temp=(H'*H)\eye(5);
    CRLB = 0.01*[temp(1,1);temp(2,2);temp(3,3);temp(4,4);temp(5,5)];
    Est_A(N-19,:)=[CRLB(1),Est_var(1)];
    Est_B(N-19,:)=[CRLB(2),Est_var(2)];
    Est_C(N-19,:)=[CRLB(3),Est_var(3)];
    Est_D(N-19,:)=[CRLB(4),Est_var(4)];
    Est_E(N-19,:)=[CRLB(5),Est_var(5)];
end
%plot A
figure();
plot([20:1:100],Est_A(:,2),'-r');
hold on
plot([20:1:100],Est_A(:,1),'-b');
xlabel('N');ylabel('var');
legend('Estimate A','CRLB of A');
title('Estimator and CRLB of A');
% %plot B
% figure();
% plot([20:1:100],Est_B(:,2),'-r');
% hold on
% plot([20:1:100],Est_B(:,1),'-b');
% xlabel('N');ylabel('var');
% legend('Estimate B','CRLB of B');
% title('Estimator and CRLB of B');
% 
% %plot C
% figure();
% plot([20:1:100],Est_C(:,2),'-r');
% hold on
% plot([20:1:100],Est_C(:,1),'-b');
% xlabel('N');ylabel('var');
% legend('Estimate C','CRLB of C');
% title('Estimator and CRLB of C');
% 
% %plot D
% figure();
% plot([20:1:100],Est_D(:,2),'-r');
% hold on
% plot([20:1:100],Est_D(:,1),'-b');
% xlabel('N');ylabel('var');
% legend('Estimate D','CRLB of D');
% title('Estimator and CRLB of D');
% 
% %plot E
% figure();
% plot([20:1:100],Est_E(:,2),'-r');
% hold on
% plot([20:1:100],Est_E(:,1),'-b');
% xlabel('N');ylabel('var');
% legend('Estimate E','CRLB of E');
% title('Estimator and CRLB of E');
% 
% 
% %plot A
% figure();
% plot([20:1:100],Est_mean(:,1),'-r');
% hold on
% plot([20:1:100],0.5*ones(81,1),'-b');
% xlabel('N');ylabel('mean');
% legend('Estimate A','True A');
% title('Estimator mean of A and true A');
% %plot B
% figure();
% plot([20:1:100],Est_mean(:,2),'-r');
% hold on
% plot([20:1:100],-0.5*ones(81,1),'-b');
% xlabel('N');ylabel('mean');
% legend('Estimate B','True B');
% title('Estimator mean of B and true B');
% %plot C
% figure();
% plot([20:1:100],Est_mean(:,3),'-r');
% hold on
% plot([20:1:100],0.07*ones(81,1),'-b');
% xlabel('N');ylabel('mean');
% legend('Estimate C','True C');
% title('Estimator mean of C and true C');
% %plot D
% figure();
% plot([20:1:100],Est_mean(:,4),'-r');
% hold on
% plot([20:1:100],-0.005*ones(81,1),'-b');
% xlabel('N');ylabel('mean');
% legend('Estimate D','True D');
% title('Estimator mean of D and true D');
% %plot E
% figure();
% plot([20:1:100],Est_mean(:,5),'-r');
% legend('Estimate E');
% xlabel('N');ylabel('mean');
% title('Estimator mean of E and true E');