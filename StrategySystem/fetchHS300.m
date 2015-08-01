function HS300=fetchHS300
%this function crawls history data of the index HS300 online
connect=yahoo;
fields={'Close'};
FromDate='01-Sep-2011';
ToDate='21-May-2015';
HS300=fetch(connect,'000300.SS',fields,FromDate,ToDate);