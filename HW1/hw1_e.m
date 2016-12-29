clear all; close all;
%% (e)
Est_A=zeros(81,2);
Est_B=zeros(81,2);
Est_C=zeros(81,2);
Est_D=zeros(81,2);
Est_mean=zeros(81,4);
for N=20:100
    M=1000;
    CRLB_B=0; CRLB_C=0; CRLB_D=0;
    for i=0:N-1;
        CRLB_B = CRLB_B+i;
        CRLB_C = CRLB_C+i^2;
        CRLB_D = CRLB_D+i^3;
    end
    Est_record=zeros(M,4);
    for i=1:M
        theta = [0.5;-0.5;0.07;-0.005];
        w = normrnd(0,0.1,N,1); % because variance is 0.01 ,so sigma is 0.1 
        x = zeros(N,1);
        H = zeros(20,4);
        for j=0:N-1
            H(j+1,:)=[1,j,j^2,j^3];
            x(j+1)=H(j+1,:)*theta+w(j+1);
        end
        Est_theta = (H'*H)\H'*x;
        Est_record(i,:)=Est_theta';
    end
    Est_mean(i,:) = mean(Est_record)';
    Est_var = var(Est_record)';
    temp=pinv(H'*H);
    CRLB = 0.01*[temp(1,1);temp(2,2);temp(3,3);temp(4,4)];
    Est_A(N-19,:)=[CRLB(1),Est_var(1)];
    Est_B(N-19,:)=[CRLB(2),Est_var(2)];
    Est_C(N-19,:)=[CRLB(3),Est_var(3)];
    Est_D(N-19,:)=[CRLB(4),Est_var(4)];      
end

%plot A
figure();
plot([20:1:100],Est_A(:,2),'-r');
hold on
plot([20:1:100],Est_A(:,1),'-b');
xlabel('N');ylabel('var');
legend('Estimate A','CRLB of A');
title('Estimator and CRLB of A');
%plot B
figure();
plot([20:1:100],Est_B(:,2),'-r');
hold on
plot([20:1:100],Est_B(:,1),'-b');
xlabel('N');ylabel('var');
legend('Estimate B','CRLB of B');
title('Estimator and CRLB of B');

%plot C
figure();
plot([20:1:100],Est_C(:,2),'-r');
hold on
plot([20:1:100],Est_C(:,1),'-b');
xlabel('N');ylabel('var');
legend('Estimate C','CRLB of C');
title('Estimator and CRLB of C');

%plot D
figure();
plot([20:1:100],Est_D(:,2),'-r');
hold on
plot([20:1:100],Est_D(:,1),'-b');
xlabel('N');ylabel('var');
legend('Estimate D','CRLB of D');
title('Estimator and CRLB of D');
