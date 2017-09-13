addpath('C:\Users\Mochong\Desktop\10725\hw1\hw1_data_files')  
filename1='train.csv';
filename2='test.csv';
A=importdata(filename1);
B=importdata(filename2);
A1=A.data;
Xtr=A1(:,1:end-1);
Ytr=A1(:,end);
B1=B.data;
Xte=B1(:,1:end-1);
Yte=B1(:,end);
n=size(Xtr,2);
m1=size(Xtr,1);
m2=size(Xte,1);
Etr=[];
Ete=[];
for k=-8:1:8
    C=10^(-k/2);
cvx_begin
    variable w(n)
    variable b
    minimize( norm( w, 2 )^2 + C*sum((max((1-(w'*(Xtr')+b)'.*Ytr),0))));
cvx_end
error_rate_train=1-length(find(sign((w'*(Xtr')+b))'.*Ytr>0))/m1;
error_rate_test=1-length(find(sign((w'*(Xte')+b))'.*Yte>0))/m2;
Etr=[Etr,error_rate_train];
Ete=[Ete,error_rate_test];
end
K=-8:1:8;
CC=10.^(-K/2);
plot(K,Etr,'r*')
hold on
plot(K,Ete,'b+')