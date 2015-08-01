function WarningSystemByMark(listofmonitor,changetodaytolerate,change10tolerate,listofinterest,upperlimit,downlimit)
%this is the main function of my warning system, it monitors those stocks I
%choose and send me warings when a stock trigers the settled rules.
%It will send warnings in two situations
%1.When the change of trading price of a stock in listofmonitor exceeds the
%changetodaytolerate in one trading day or exceeds change10tolerate in ten
%minutes, it will triger a warning.
%2.When the price of a stock in listofinterest hits the upperlimit or
%downlimit, it will triger a warning


%Start to work at 9:15am
n=size(listofmonitor,1);
n1=size(listofinterest,1);
while true
    t=clock;
    if t(4)==9&&t(5)==15
        %generate the history dataset
        [no,open,close,max,min,volume]=catchdatahistory(listofmonitor);
        continue;
    end
    if (t(4)==9&&t(5)==30)|| t(4)==13
        %generate the current dataset and begins running
        last10=zeros(n,1);
        last9=zeros(n,1);
        last8=zeros(n,1);
        last7=zeros(n,1);
        last6=zeros(n,1);
        last5=zeros(n,1);
        last4=zeros(n,1);
        last3=zeros(n,1);
        last2=zeros(n,1);
        last1=zeros(n,1);
        current=catchdatanow(listofmonitor);
        %Open Alert!
        content='Opening Brief';
        for h=1:n
            content=strcat(content,listofmonitor(h,:),' Open at ',num2str(current(h)),'\n');
        end
        sendwarning('Open Brief','By MarkHe',content);
        %Send me the opening situations
        pause(60);
        while(t(4)<=15)
            %catch the new data
            last10=last9;
            last9=last8;
            last8=last7;
            last7=last6;
            last6=last5;
            last5=last4;
            last4=last3;
            last3=last2;
            last2=last1;
            last1=current;
            current=catchdatanow(listofmonitor);
            %generate warning today
            changetoday=abs(current-close)./close;
            for h=1:n
                if changetoday(h)>changetodaytolerate
                    sendwarning(num2str(no(h)),' today ',num2str(current(h)));
                    changetodaytolerate=changetodaytolerate+0.05;
                end
            end
            %generate warning 10mins
            change10=abs(current-last10)./last10;
            for h=1:n
                if change10(h)>change10tolerate && last10(h)~=0
                    sendwarning(num2str(no(h)),' 10mins ',num2str(current(h)));
                    change10tolerate=change10tolerate+0.05;
                end
            end
            pricenow=catchdatanow(listofinterest);
            for h=1:n1
                if pricenow(h)>=upperlimit(h)
                    sendwarning(listofinterest(h,:),' upperlimits hit! ',num2str(pricenow(h)));
                    upperlimit(h)=upperlimit(h)*1.1;
                end
                if pricenow(h)<=downlimit(h)
                    sendwarning(listofinterest(h,:),' downlimits hit! ',num2str(pricenow(h)));
                    downlimit(h)=downlimit(h)*0.85;
                end
            end
                
            pause(50); %It shall operate for 10 secs for each time.....
        end
        %Close Alert!
        [no,open,close,max,min,volume]=catchdatahistory(listofmonitor);
        for h=1:n
        sendwarning(listofmonitor(h,:),strcat('Open at',num2str(open(h)),' Volume= ',num2str(volume(h)),'Max',num2str(max(h)),'Min',num2str(min(h)),' Close at '),current(h));
        end
    end
end
            
        
end


%An example of how to use it.

%listofmonitor=['600000';'600001']
% listofinterest=listofmonitor
% changetodaytolerate=[0.05;0.05]
% change10tolerate=[0.02;0.02]
% upperlimit=[10;11]
% downlimit=[7;8]
% WarningSystemByMark(listofmonitor,changetodaytolerate,change10tolerate,listofinterest,upperlimit,downlimit)
    