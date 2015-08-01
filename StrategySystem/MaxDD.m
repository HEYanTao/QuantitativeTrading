function [maxdown,maxdowntime]=MaxDD(value)
%this function calculates the max retracement time span
high=zeros(size(value));
drawdown=zeros(size(value));
drawdowntime=zeros(size(value));
for t=2:length(value)
    high(t)=max(high(t-1),value(t));
    drawdown(t)=(high(t)-value(t))/high(t);
    if(drawdown(t)==0)
        drawdowntime(t)=0;
    else
        drawdowntime(t)=drawdowntime(t-1)+1;
    end
end
maxdown=max(drawdown);
maxdowntime=max(drawdowntime);