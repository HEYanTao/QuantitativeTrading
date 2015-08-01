function current=catchdatanow(listofinterest)
%This function crawls only curent price data from the Sina Stock API.
%It reads in a number matrix of stocks and collect some data of these stocks.
%It outputs one matrix named current
%current includes data of the trading prices of those stocks in listofinterest 

%First, initialize those variables
n=size(listofinterest,1);
current=zeros(n,1);

for i=1:n
    %this if sentence here is used to determine in which exchange does
    %the stock traded, it's in either shanghai or shenzhen
   if str2double(listofinterest(i,:))>600000
        url=strcat('http://hq.sinajs.cn/list=sh',listofinterest(i,:));
    else
        url=strcat('http://hq.sinajs.cn/list=sz',listofinterest(i,:));
    end
        [str1,status]=urlread(url);
        str=regexp(str1,',','split');
        if (status<1)
            error(strcat('Error in extracting the number:',num2str(i),' item!\n'))
            return 
        else
            current(i)=str2double(str(4));
        end
end