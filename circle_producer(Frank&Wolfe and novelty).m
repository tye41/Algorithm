clear all;
data=randn(2,100);
scatter(data(1,:),data(2,:));
hold on

%Set the A and b
bi=-diag(data'*data);
aij=2*data'*data;
k=size(data,2);
alpha1=zeros(k,1);
alpha1(k)=1;
min_lamda=1.01;
pre_lamda=1.02;


tic
% stop the iteration when step-size=0
while  pre_lamda-min_lamda>10^-6
pre_lamda=min_lamda;
gradient=aij*alpha1+bi;
[~,label_1]=min(gradient,[],1);

%gradient min is appear in the smallest element in gradient
alpha2=zeros(k,1);
alpha2(label_1)=1;

%find the smallest value when we use the new point
y1=zeros(1,k+1);
for i=0:100
    x=i*0.01;
y1(i+1) = 0.5*((1-x)*alpha1+x*alpha2)'*aij*((1-x)*alpha1+x*alpha2)+bi'*((1-x)*alpha1+x*alpha2);
end
[~,label_2]=min(y1,[],2);
min_lamda=(label_2-1)/k;

% specify the new point
alpha1=(1-min_lamda)*alpha1+min_lamda*alpha2;
end
toc

%find the largest 10 distance between center
c=data*alpha1;
r=diag((data-c)'*(data-c));
[~,rmax]=maxk(r,10,1);
novelty=data(:,rmax)

% draw a circle to make the picture clearly
data(:,rmax)=[];
bi=-diag(data'*data);
aij=2*data'*data;
k=size(data,2);
alpha1=zeros(k,1);
alpha1(k)=1;
min_lamda=1;
while min_lamda~=0 || min_lamda-pre_lamda>10^-5
pre_lamda=min_lamda;
gradient=aij*alpha1+bi;
[~,label_1]=min(gradient,[],1);
alpha2=zeros(k,1);
alpha2(label_1)=1;
y2=zeros(1,101);
for i=0:100
    x=i*0.01;
y2(i+1) = 0.5*((1-x)*alpha1+x*alpha2)'*aij*((1-x)*alpha1+x*alpha2)+bi'*((1-x)*alpha1+x*alpha2);
end
[~,label_2]=min(y2,[],2);
min_lamda=(label_2-1)/100;
alpha1=(1-min_lamda)*alpha1+min_lamda*alpha2;

end

c=data*alpha1;
label_3=find(alpha1~=0);
data_example=data(:,label_3(1));
r=(data_example-c)'*(data_example-c);
viscircles(c',r^0.5);


