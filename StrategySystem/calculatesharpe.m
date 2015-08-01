function sharpe=calculatesharpe(value,r)
%this function calculate the sharpe ratio of this strategy
dailyret=(value(2:end)-value(1:end-1))./value(1:end-1);%the gain rate every day
excessGain=dailyret-nthroot(1+r,252)+1;
sharpe=sqrt(252)*mean(excessGain)/std(excessGain);
