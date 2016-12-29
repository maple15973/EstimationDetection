%% (b)
N = 20;
theta = [0.5;-0.5;0.07;-0.005];
w = normrnd(0,0.1,N,1); % because variance is 0.01 ,so sigma is 0.1 
x = zeros(N,1);
H = zeros(20,3);
for i=0:N-1
    H(i+1,:)=[1,i,i^2];
    x(i+1)=[1,i,i^2,i^3]*theta+w(i+1);
end
temp=pinv(H'*H);
Est_theta = pinv(H'*H)*H'*x;
CRLB = 0.01*[temp(1,1);temp(2,2);temp(3,3)];
%% (c)
N = 20;
M=1000;
Est_record=zeros(M,3);
for i=1:M
    theta = [0.5;-0.5;0.07;-0.005];
    w = normrnd(0,0.1,N,1); % because variance is 0.01 ,so sigma is 0.1 
    x = zeros(N,1);
    H = zeros(20,3);
    for j=0:N-1
        H(j+1,:)=[1,j,j^2];
        x(j+1)=[1,j,j^2,j^3]*theta+w(j+1);
    end
    Est_theta = pinv(H'*H)*H'*x;
    Est_record(i,:)=Est_theta';
end
Est_mean = mean(Est_record)';
Est_var = var(Est_record)';
temp=pinv(H'*H);
CRLB = 0.01*[temp(1,1);temp(2,2);temp(3,3)];

%% (d)
N=100;
M=1000;
Est_record=zeros(M,3);
for i=1:M
    theta = [0.5;-0.5;0.07;-0.005];
    w = normrnd(0,0.1,N,1); % because variance is 0.01 ,so sigma is 0.1 
    x = zeros(N,1);
    H = zeros(20,3);
    for j=0:N-1
        H(j+1,:)=[1,j,j^2];
        x(j+1)=[1,j,j^2,j^3]*theta+w(j+1);
    end
    Est_theta = pinv(H'*H)*H'*x;
    Est_record(i,:)=Est_theta';
end
Est_mean = mean(Est_record)';
Est_var = var(Est_record)';
temp=pinv(H'*H);
CRLB = 0.01*[temp(1,1);temp(2,2);temp(3,3)];


%% (e)
Est_A=zeros(81,2);
Est_B=zeros(81,2);
Est_C=zeros(81,2);
Est_D=zeros(81,2);
Est_mean=zeros(81,3);
for N=20:100
    M=1000;
    Est_record=zeros(M,3);
    for i=1:M
        theta = [0.5;-0.5;0.07;-0.005];
        w = normrnd(0,0.1,N,1); % because variance is 0.01 ,so sigma is 0.1 
        x = zeros(N,1);
        H = zeros(N,3);
        for j=0:N-1
            H(j+1,:)=[1,j,j^2];
            x(j+1)=[1,j,j^2,j^3]*theta+w(j+1);
        end
        Est_theta = pinv(H'*H)*H'*x;
        Est_record(i,:)=Est_theta';
    end
    Est_mean(N-19,:) = mean(Est_record);
    Est_var = var(Est_record)';
    temp=pinv(H'*H);
    CRLB = 0.01*[temp(1,1);temp(2,2);temp(3,3)];
    Est_A(N-19,:)=[CRLB(1),Est_var(1)];
    Est_B(N-19,:)=[CRLB(2),Est_var(2)];
    Est_C(N-19,:)=[CRLB(3),Est_var(3)];
end
%plot A
figure();
plot([20:1:100],Est_mean(:,1),'-r');
hold on
plot([20:1:100],0.5*ones(81,1),'-b');
xlabel('N');ylabel('mean');
legend('Estimate A','True A');
title('Estimator mean of A and true A');
%plot B
figure();
plot([20:1:100],Est_mean(:,2),'-r');
hold on
plot([20:1:100],-0.5*ones(81,1),'-b');
xlabel('N');ylabel('mean');
legend('Estimate B','True B');
title('Estimator mean of B and true B');
%plot C
figure();
plot([20:1:100],Est_mean(:,3),'-r');
hold on
plot([20:1:100],0.07*ones(81,1),'-b');
xlabel('N');ylabel('mean');
legend('Estimate C','True C');
title('Estimator mean of C and true C');