clc; close all;clear all;
A = 1;
f = 0.06;
phi = pi/4;
v = 0.05;
N = 100;
M=1000;
step_snr = -20:0.1:20;
test_v = 0.5 * 10.^(-step_snr/10);
L=length(test_v);
%% (f)
dev = 100;
var_phi_by_formula=zeros(L,1);
var_phi =zeros(L,1); 
m_phi_by_formula = zeros(L,1);
fx1=[];fx2=[];tx=[];
for i=1:N
    fx1=[fx1;sin(2*pi*f*i)];
    fx2=[fx2;cos(2*pi*f*i)];
    tx=[tx;cos(2*pi*f*i+phi)];
end

for i=1:L
    phi_by_formula=zeros(M,1);
    for j=1:M
        t_x=A*tx+normrnd(0,sqrt(test_v(i)),N,1);
        phi_by_formula(j) = -atan((t_x'*fx1)/(t_x'*fx2));
    end
    var_phi_by_formula(i) = var(phi_by_formula);
    m_phi_by_formula(i) = mean(phi_by_formula);
    var_phi(i) = 2 * test_v(i) / N;
end
figure;
plot(step_snr,N*var_phi_by_formula);
xlabel('SNR');ylabel('N*var');
hold on
plot(step_snr,N*var_phi,'--');
xlabel('SNR');ylabel('N*var');
legend('Monte Carlo','Asymptotic')
figure;
plot(step_snr,m_phi_by_formula);
xlabel('SNR');ylabel('Mean');
hold on
plot(step_snr,pi/4*ones(L,1));
legend('Simulation','True mean','Location','southeast');
