%% (c)
N = 20;
M=1000;
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
    Est_theta = pinv(H'*H)*H'*x;
    Est_record(i,:)=Est_theta';
end
Est_mean = mean(Est_record)';
Est_var = var(Est_record)';
temp=pinv(H'*H);
CRLB = 0.01*[temp(1,1);temp(2,2);temp(3,3);temp(4,4)];