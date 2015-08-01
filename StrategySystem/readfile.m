function [num,txt]=readfile(filename)
%this function reads in a csv file
%sum indicates the initial investment
[num,txt]=xlsread(filename);

