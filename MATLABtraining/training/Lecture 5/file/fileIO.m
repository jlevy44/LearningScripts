a=importdata('textFile.txt',' ') %says important data separated by spaces
%creates struct w/ data, textdata and colheaders fields

x=a.data
names=a.colheaders

%also use fscanf,textread,textscan; see help or doc for more info

%can write to xls documents, excel
[s,m]=xlswrite('randomNumbers',rand(10,4),'Sheet1')
C={'hello','goodbye';10,-2;-3,4};
[s,m]=xlswrite('randomNumbers',C,'mixedData') %writes to a different sheet within doc
    %brackets for cell, can convert cell to xls
    %cannot write to excel, find out why... has backup methods though
 [num,txt,raw]=xlsread('randomNumbers.xls','randomNumbers.csv')
 %num is numbers, txt contains strings, raw is entire doc
 %GUIs lec 5 p.28
 %see new folder