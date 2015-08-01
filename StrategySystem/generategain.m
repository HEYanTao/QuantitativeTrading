function gain=generategain(num,r)
%This file generates the gain of a certain strategy
n=size(num,1);
t=size(num,2);
for i=1:n
    for j=1:t-1
        if(num(i,t-j)==0)
            num(i,t-j)=num(i,t-j+1);
        end
    end
end
gain=zeros(n+1,t);

gain(:,1)=1;%n+1 stock is no invest thus the gain is always 1
gain(end,:)=(nthroot(1+r,252));
for i=2:t
    gain(1:n,i)=num(1:n,i)./num(1:n,i-1);
end
gain(find(isnan(gain)==1)) = 1;%get rid of all NaN
gain(find(isinf(gain)==1))=1;