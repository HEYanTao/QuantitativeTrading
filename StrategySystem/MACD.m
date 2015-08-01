function [macd,dif,dea]=MACD(num,txt,span)
%here span indicates the span to calculate DEA mostlt 9
%this is a strategy function!!!!
%short and long span result could get by applying twice,short term is
%normally 12 long term 26
%return the ma for the last (date-day+1)days

ema1=MA(num,txt,12);
ema2=MA(num,txt,26);

t=min(size(ema1,2),size(ema2,2));%indicates how many days
n=size(num,1);%indicates how many stocks

%smooth the original data

dif=ema1(:,(end-t+1):end)-ema2;
dea=zeros(n,t-span+1);
for i=1:t-span+1
    for j=1:n
    dea(j,i)=sum(dif(j,i))./(span);
    end
end

macd=2*(dif(:,(span):end)-dea);
dif=dif(:,span:end);


% for test and debugging
%date=txt(2,(2+span):(t+1));
% bar(macd(2,:));
% hold on;
% plot(dif(2,:),'m');
% plot(dea(2,:),'c');
% plot(num(2,33:end),'r');
% legend('macd','dif','dea','ema');