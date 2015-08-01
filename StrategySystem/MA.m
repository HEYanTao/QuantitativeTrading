function ma=MA(num,txt,span)
%this function generates the MA value
%short and long span result could get by applying twice
%return the ma for the last (date-day+1)days

t=size(num,2);%indicates how many days
n=size(num,1);%indicates how many stocks

%smooth the original data
for i=1:n
    for j=1:t-1
        if(num(i,t-j)==0)
            num(i,t-j)=num(i,t-j+1);
        end
    end
end

ma=zeros(n,t-span+1);
for i=1:t-span+1
    for j=1:n
    ma(j,i)=sum(num(j,i:(i+span-1)))./(span);
    end
end

% for test and debugging
% date=txt(2,(2+span):(t+1));
% plot(ma(2,:));
% hold on;
% plot(num(2,span:t),'r');