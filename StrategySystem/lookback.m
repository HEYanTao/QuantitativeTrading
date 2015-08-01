function [value,sharpe,maxdown,maxdowntime,sharpec,maxdownc,maxdowntimec]=lookback(filename,total,r)
%This function is used to look back a strategy's performance

%Input arguments:
%filename determines the stocks to choose from,r is the interest rate
%(The file decides which stocks to choose from and what time span to look
%back in this program.)
%total determines the initial investment
%r determines the interest rate

%Output arguments:
%value is the final amount of investment
%sharpe is the sharpe ratio of this strategy
%maxdown is the biggest retracement of this strategy
%maxdowntime is the logest retracement time span
%Use the perfoemance of the index HS300 to compare from our strategy
%sharpec,maxdownc,maxdowntimec are the performance of HS300


[num,txt]=readfile(filename);
%n=size(txt,1);%indicates how many stocks
t1=size(num,2);%indicates how many days           
%date=txt(2,3:(t+2));


%%change your strategy here!
% for tt=5:25
%     tt
%     [num,txt]=readfile(filename);
%     t1=size(num,2);

holdings=strategy(filename,13); %strategy generates a matrix with t colums and n+1 rows in each column shows the holding that day
% tt=1;
% k=0.01;
% holdings=strategyAMA(filename,tt,k);



%the +1 row means no invest
t=size(holdings,2);
%modify time to fit particular strategy
deltat=t1-t+1;
num=num(:,deltat:end);
n=size(holdings,1);
gain=generategain(num,r);
value=zeros(t,1);
value(1)=total;
for i=2:t
    value(i)=value(i-1).*sum(holdings(:,i).*gain(:,i));
       for j=1:n-1
        if(holdings(j,i)~=holdings(j,i-1))
            value(i)=value(i)-abs(holdings(j,i)-holdings(j,i-1))*0.005*total;% trading fee!!
        end
%         if(i==76||i==77)
%                 fee(j)=abs(holdings(j,i)-holdings(j,i-1))*0.005*total
%             end
        end
end
plot(value);
%hold on;
sharpe=calculatesharpe(value,r);
[maxdown,maxdowntime]=MaxDD(value);
%value(end)
%end

%%compare
holdings2=index('HS300Closing.csv',t);
%modify time to fit particular strategy
[num,txt]=readfile('HS300Closing.csv');
num=num(:,deltat:end);
gain=generategain(num,r);
valuec=zeros(t,1);
valuec(1)=total;
for i=2:t
    valuec(i)=valuec(i-1).*sum(holdings2(:,i).*gain(:,i));
 
            
end
%plot(10.*valuec,'r');
sharpec=calculatesharpe(valuec,r);
[maxdownc,maxdowntimec]=MaxDD(valuec);