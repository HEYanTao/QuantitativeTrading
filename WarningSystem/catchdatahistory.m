function [no,open,close,max,min,volume]=catchdatahistory(listofinterest)
%This function crawls data from the Sina Stock API.
%It reads in a number matrix of stocks and collect some data of these stocks.
%It outputs six matrixs named no,open,close,max,min,volume
%Those data include the 
%stock number: no 
%open price: open
%close price: close
%max price of the day: max
%min price of the day: min
%trading volume: volume

%First, initialize those variables
n=size(listofinterest,1);
no=listofinterest;
open=zeros(n,1);
close=zeros(n,1);
max=zeros(n,1);
min=zeros(n,1);
volume=zeros(n,1);

%Second, crawl information online using urlread
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
            open(i)=str2double(str(2));
            close(i)=str2double(str(3));
            max(i)=str2double(str(5));
            min(i)=str2double(str(6));
            volume(i)=str2double(str(9));
        end
end
        
        
        

        