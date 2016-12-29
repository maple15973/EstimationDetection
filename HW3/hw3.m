clc; clear all; close all;
N = 100;
f = 1/16;
H = zeros(N,2);
M = 10^5;
sig = 1;
for i=1:N
    H(i,1) = cos(2*pi*f*(i-1));
    H(i,2) = sin(2*pi*f*(i-1));
end
true_theta_mean=zeros(41,2);
est_theta_mean=zeros(41,2);
true_theta_var=zeros(41,2);
est_theta_var=zeros(41,2);
mse_theta=zeros(41,2);
Bmse=zeros(41,1);

for SNR = -20:20
    SNR
    sig_theta = sig*10^(SNR/10);
    est_theta = zeros(2,M);
    theta= normrnd(0,sqrt(sig_theta),2,M);
    w = normrnd(0,sqrt(sig),N,M);
    x = H*theta+w;
    est_theta = sig_theta*H'*x/(1+N/2 * sig_theta/sig);
    true_theta_mean(SNR+21,:)=mean(theta,2);
    est_theta_mean(SNR+21,:)=mean(est_theta,2);
    true_theta_var(SNR+21,:)=var(theta,0,2);
    est_theta_var(SNR+21,:)=var(est_theta,0,2);
    mse_theta(SNR+21,:) = mean((theta-est_theta).^2,2)'; 
    Bmse(SNR+21)=sig_theta/(1+N*sig_theta/(2*sig));
end
x_axis =[-20:20];
figure;
subplot(2,1,1);
plot(x_axis,true_theta_mean(:,1),'b-');
hold on
plot(x_axis,est_theta_mean(:,1),'bo');
xlabel('SNR');ylabel('Mean');
legend('true-a', '$\hat a$','Location','SouthEast');
set(legend,'Interpreter','latex')
title('$\hat a$ vs true-a', 'Interpreter', 'latex');
subplot(2,1,2);
plot(x_axis,true_theta_mean(:,2),'r-');
hold on
plot(x_axis,est_theta_mean(:,2),'ro');
xlabel('SNR');ylabel('Mean');
legend('true-b', '$\hat b$','Location','SouthEast');
set(legend,'Interpreter','latex')
title('$\hat b$ vs true-b', 'Interpreter', 'latex');
figure;
subplot(2,1,1);
plot(x_axis,true_theta_var(:,1),'b-');
hold on
plot(x_axis,est_theta_var(:,1),'bo');
xlabel('SNR');ylabel('Var');
legend('true-a', '$\hat a$','Location','NorthWest');
set(legend,'Interpreter','latex')
title('$\hat a$ vs true-a', 'Interpreter', 'latex');
subplot(2,1,2);
plot(x_axis,true_theta_var(:,2),'r-');
hold on
plot(x_axis,est_theta_var(:,2),'ro');
xlabel('SNR');ylabel('Var');
legend('true-b', '$\hat b$','Location','NorthWest');
set(legend,'Interpreter','latex')
title('$\hat b$ vs true-b', 'Interpreter', 'latex');
% 
figure;
plot(x_axis,mse_theta(:,1),'b-'); hold on
plot(x_axis,Bmse,'r--'); 
legend('Bmse(a)', 'Bmse($\hat a$)','Location','SouthEast');
set(legend,'Interpreter','latex')
xlabel('SNR');ylabel('MSE');
title('MSE of estimator a');
figure; 
plot(x_axis,mse_theta(:,2),'b-'); hold on
plot(x_axis,Bmse,'r--'); 
legend('Bmse(b)', 'Bmse($\hat b$)','Location','SouthEast');
set(legend,'Interpreter','latex')
xlabel('SNR');ylabel('MSE');
title('MSE of estimator b');
%% SNR=20
% SNR=20;
% sig_theta = sig*10^(SNR/10);
% true_theta = zeros(2,M);
% est_theta = zeros(2,M);
% theta= normrnd(0,sqrt(sig_theta),2,M);
% w = normrnd(0,sqrt(sig),N,M);
% x = H*theta+w;
% est_theta = sig_theta*H'*x/(1+N/2 * sig_theta/sig);
% est_theta_mean=mean(est_theta,2);
% est_theta_var=var(est_theta,0,2);
% norm = normpdf(-50:1:50,est_theta_mean(1),sqrt(est_theta_var(1)));
% figure;
% yyaxis left
% histogram(theta(1,:));
% yyaxis right
% plot(-50:1:50,norm,'LineWidth',2);
% %% SNR=-20
% SNR=-20;
% sig_theta = sig*10^(SNR/10);
% true_theta = zeros(2,M);
% est_theta = zeros(2,M);
% theta= normrnd(0,sqrt(sig_theta),2,M);
% w = normrnd(0,sqrt(sig),N,M);
% x = H*theta+w;
% est_theta = sig_theta*H'*x/(1+N/2 * sig_theta/sig);
% est_theta_mean=mean(est_theta,2);
% est_theta_var=var(est_theta,0,2);
% norm = normpdf(-0.5:0.01:0.5,est_theta_mean(1),sqrt(est_theta_var(1)));
% figure;
% yyaxis left
% histogram(theta(1,:));
% yyaxis right
% plot(-0.5:0.01:0.5,norm,'LineWidth',2);
% %% SNR=100
% SNR=100;
% sig_theta = sig*10^(SNR/10);
% true_theta = zeros(2,M);
% est_theta = zeros(2,M);
% theta= normrnd(0,sqrt(sig_theta),2,M);
% w = normrnd(0,sqrt(sig),N,M);
% x = H*theta+w;
% est_theta = sig_theta*H'*x/(1+N/2 * sig_theta/sig);
% est_theta_mean=mean(est_theta,2);
% est_theta_var=var(est_theta,0,2);
% norm = normpdf(-5*10^5:10^4:5*10^5,est_theta_mean(1),sqrt(est_theta_var(1)));
% figure;
% yyaxis left
% histogram(theta(1,:));
% yyaxis right
% plot(-5*10^5:10^4:5*10^5,norm,'LineWidth',2);
% %% SNR=0
% SNR=0;
% sig_theta = sig*10^(SNR/10);
% true_theta = zeros(2,M);
% est_theta = zeros(2,M);
% theta= normrnd(0,sqrt(sig_theta),2,M);
% w = normrnd(0,sqrt(sig),N,M);
% x = H*theta+w;
% est_theta = sig_theta*H'*x/(1+N/2 * sig_theta/sig);
% est_theta_mean=mean(est_theta,2);
% est_theta_var=var(est_theta,0,2);
% norm = normpdf(-5:0.1:5,est_theta_mean(1),sqrt(est_theta_var(1)));
% figure;
% yyaxis left
% histogram(theta(1,:));
% yyaxis right
% plot(-5:0.1:5,norm,'LineWidth',2);