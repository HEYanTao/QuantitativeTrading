function strategy=index(filename,t)
[num,txt]=readfile(filename);
n=size(num,1);%indicates how many stocks
strategy1=ones(n,t).*(1/n);
strategy=zeros(n+1,t);
strategy(1:n,:)=strategy1;



        
