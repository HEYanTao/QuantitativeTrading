function [closingprice,date]=closeprice(stockID,num,txt)
date=txt(2,3:1236);%may need to change according to different files!
IDlist=txt(3:302,1);
n=size(IDlist,1);
for i=1:n
    if(strcmp(stockID,IDlist(i)))
        closingprice=num(i,:);
        return
    end
end

