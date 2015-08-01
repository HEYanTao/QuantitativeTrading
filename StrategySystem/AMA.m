function AMA=AMA(filename)
%this function generates the AMA line
[num,txt]=readfile(filename);
n=size(num,1);%indicates how many stocks
t=size(num,2);%indicates how many days
fast=2/(2+1);
slow=2/(30+1);
span=10;
AMA=zeros(n,t);
AMA(:,1:span)=num(:,1:span);
for j=1:n
for i=span+1:t
    direction=abs(num(j,i)-num(j,i-span));
    p1=num(j,(i-span+1):i);
    p2=num(j,(i-span):(i-1));
    volatility=sum(abs(p1-p2));
    if (volatility==0)
        ER=0;
    else
    ER=direction/volatility;
    end
    smooth=ER*(fast-slow)+slow;
    c=smooth*smooth;
    AMA(j,i)=AMA(j,i-1)+c*(num(j,i)-AMA(j,i-1));
%     if (isnan(AMA(j,i)))
%         p1
%         p2
%         volatility
%         ER
%         smooth
%         c
%         AMA(j,i)
%         AMA(j,i-1)
%         return
%     end
end
end
% plot(AMA(2,:),'r');
% hold on;
% plot(num(2,:),'b');
    