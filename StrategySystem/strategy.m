function strategy=strategy(filename,tt)
%this is the strategy using MACD
%It reads in the current situation and determine which stock to buy
%filename indicates a file which determines from which stocks to choose
%It outputs the matrix strategy


[num,txt]=readfile(filename);
n=size(num,1);%indicates how many stocks
t=size(num,2);%indicates how many days
%date=txt(2,3:(t+2));
[macd,dif,dea]=MACD(num,txt,tt);
t=size(macd,2);
%using MACD to generate strategy
strategy1=zeros(n,t-1);
for j=2:t
for i=1:n
   % if (dif(i,j)>0&&dea(i,j)>0)
%         if ((dif(i,j)>dea(i,j))&&dif(i,j-1)<=dea(i,j-1))
%             strategy(i,j-1)=strategy(i,j-1)+1; %%generate a signal to buy some!
%         end
   % end
    if(macd(i,j)>0&&macd(i,j-1)<=0)
         strategy1(i,j-1)=1; %%generate a signal to buy!
    end
    
   % if (dif(i,j)<0&&dea(i,j)<0)
%         if ((dif(i,j)<dea(i,j))&&dif(i,j-1)>=dea(i,j-1))
%             strategy(i,j-1)=-1; %%generate a signal to sell all!
%         end
   % end
    if(macd(i,j)<0&&macd(i,j-1)>=0)
         strategy1(i,j-1)=-1; %%generate a signal to sell!
    end
end
end
strategy=zeros(n+1,t-1);
for j=1:t-1
    if (j==1)
        strategy(1:n,1)=strategy1(:,1);
        strategy(n+1,1)=1;
    else
        for i=1:n
            if(strategy1(i,j)>=0)
                strategy(i,j)=strategy(i,j-1)+strategy1(i,j);
            else
                strategy(i,j)=0;
            end
%              if(strategy(i,j)<=0.05)
%                  %control the minimum holding share of a stock
%                  strategy(i,j)=0;
%              end
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
        
        
    
