function strategy=strategyAMA(filename,tt,k)
%tt=5;%tt indicates considering how many days
AMAValue=AMA(filename);
[num,txt]=readfile(filename);
%filter
n=size(AMAValue,1);%indicates how many stocks
t=size(AMAValue,2);%indicates how many days
tolerate=zeros(n,1);
for i=1:n
tolerate(i,1)=k*std((AMAValue(i,:)-AMAValue(i,1)),1,2);%k is here!
end

strategy=zeros(n+1,t);
strategy1=zeros(n,t);
for i=1:n
    for j=(tt+1):t
        if((AMAValue(i,j)-min(AMAValue(i,(j-tt):j))>tolerate(i,1)))
            if((num(i,j)>AMAValue(i,j))&&(num(i,j-1)>AMAValue(i,j-1)))
               strategy1(i,j)=1;%buy
            end
        end
         if((-AMAValue(i,j)+max(AMAValue(i,(j-tt):j))>tolerate(i,1)))
            if((num(i,j)<AMAValue(i,j))&&(num(i,j-1)<AMAValue(i,j-1)))
               strategy1(i,j)=-1;%sell
            end
         end
    end
end



for j=1:t
    if (j<=tt)
        strategy(1:n,j)=0;
        strategy(n+1,j)=1;
    else
        for i=1:n
            if(strategy1(i,j)>=0)
                strategy(i,j)=strategy(i,j-1)+strategy1(i,j);
            else
                strategy(i,j)=0;
            end
        end
    end
    all=sum(strategy(1:n,j));
    if(all>0)
        strategy(n+1,j)=0;
        strategy(:,j)=strategy(:,j).*(1/all);
    else
        strategy(1:n,j)=0;
        strategy(n+1,j)=1;
    end
    %control the minimum holding share of a stock
    for i=1:n
        if(strategy(i,j)<0.01)
            strategy(i,j)=0;
        end
    end
    all=sum(strategy(1:n,j));
    if(all>0)
        strategy(n+1,j)=0;
        strategy(:,j)=strategy(:,j).*(1/all);
    else
        strategy(1:n,j)=0;
        strategy(n+1,j)=1;
    end
    
end
% buy=find(strategy1(3,:)==1);
% sell=find(strategy1(3,:)==-1);
% plot(num(3,:));
% hold on;
% plot(AMAValue(3,:),'r');
% text(buy,num(3,buy),'o','color','r');
% text(sell,num(3,sell),'o','color','g');

         
         
        
        