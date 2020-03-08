clear all
% specify parameters 
trans = [0.95,0.05;
          0.10,0.90];
 emis = [1/6 1/6 1/6 1/6 1/6 1/6;
    1/10 1/10 1/10 1/10 1/10 1/2];
seq=[4;4;5;4;3;6;3;1;6;5;6;6;2;6;5;6;6;6];
L=length(seq);
a=zeros(2,L);
a(1,1)=0.5*trans(1,1)*emis(1,seq(1))+0.5*trans(2,1)*emis(1,seq(1));
a(2,1)=0.5*trans(1,2)*emis(2,seq(1))+0.5*trans(2,2)*emis(2,seq(1));
for t=2:L
    a(1,t)=emis(1,seq(t))*(a(:,t-1)'*trans(:,1));
    a(2,t)=emis(2,seq(t))*(a(:,t-1)'*trans(:,2));
   
end


b=zeros(2,L);
b(1,L)=1; b(2,L)=1;
for t=(L-1):-1:1
    b(1,t)=trans(1,:)*(b(:,t+1).*emis(:,seq(t+1)));
    b(2,t)=trans(2,:)*(b(:,t+1).*emis(:,seq(t+1)));
end

c=a.*b;
c=c./sum(c,1);
disp(c)
   

States= hmmviterbi(seq,trans,emis,'Statenames',{'Fair';'Loaded'});
disp(States)