data=readtable('food-consumption.csv');
data=data([1,2,3,4,5,6,7,8,9,10,12,13,16],:);
data_num=(table2array(data(:,2:21)))';
m=size(data_num,2);
Anew=data_num';
stdA = std(Anew, 1, 1); 
Anew = Anew * diag(1./stdA); 
Anew = Anew'; 
mu=sum(Anew,2)./m;
xc = bsxfun(@minus, Anew, mu); 

C = xc * xc' ./ m; 

[W, S] = eigs(C, 2); 
diag(S);
dim1 = W(:,1)' * xc ./ sqrt(S(1,1));
dim2 = W(:,2)' * xc ./ sqrt(S(2,2));

figure; 
plot(dim1, dim2, '.'); 
str=table2cell(data(:,1));
text(dim1,dim2,str);
figure;
hold on;
u = W(1,:);
v = W(2,:);
quiver(u,v)





