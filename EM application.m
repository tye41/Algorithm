clear all
load('data.mat', 'data')
data2=reshape(data(:,1),28,28);
imwrite(data2,'2.png');
data6=reshape(data(:,1200),28,28);
imwrite(data6,'6.png');


data=data';
pi2=0.5;
pi6=0.5;
mu2=0.5*randn(784,1)+0.5;
mu6=0.5*randn(784,1)+0.5;
cov2=ones(784,784);
cov6=ones(784,784);

for i=1:30
%E-step
if i>=2
cov2=cov2+diag(ones(1,784)*10^-3);
cov6=cov6+diag(ones(1,784)*10^-3);
end
zn2=pi2*exp(-0.5*(data-mu2')*pinv(cov2)*(data-mu2')');
zn6=pi6*exp(-0.5*(data-mu6')*pinv(cov6)*(data-mu6')');
normalize=diag(zn2)+diag(zn6);
zn2=diag(zn2)./normalize;
zn6=diag(zn6)./normalize;
%M-step
pi2=sum(zn2,1)/(1990);
pi6=1-pi2;
mu2=data'*zn2./sum(zn2);
mu6=data'*zn6./sum(zn6);
tmpdata2=data-repmat(mu2',1990,1);
tmpdata6=data-repmat(mu6',1990,1);
cov2=zeros(784,784);
cov6=zeros(784,784);

for m=1:1990
   cov2=cov2+tmpdata2(m,:)'*tmpdata2(m,:)*zn2(m);
   cov6=cov6+tmpdata6(m,:)'*tmpdata6(m,:)*zn6(m);
end

cov2=cov2./sum(zn2);
cov6=cov6./sum(zn6);
end
figure(1)
imshow(reshape(mu2,28,28))
figure(2)
imshow(reshape(mu6,28,28))
