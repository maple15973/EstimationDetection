%% (b)
N = 20;
theta = [0.5;-0.5;0.07;-0.005];
w = normrnd(0,0.1,N,1); % because variance is 0.01 ,so sigma is 0.1 
x = zeros(N,1);
H = zeros(20,4);
for i=0:N-1
    H(i+1,:)=[1,i,i^2,i^3];
    x(i+1)=H(i+1,:)*theta+w(i+1);
end
temp=pinv(H'*H);
Est_theta = pinv(H'*H)*H'*x;
CRLB = 0.01*[temp(1,1);temp(2,2);temp(3,3);temp(4,4)];