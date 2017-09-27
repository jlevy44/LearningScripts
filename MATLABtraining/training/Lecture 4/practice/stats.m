scores=100*rand(1,100);

hist(scores,5:10:95);
%histogram bins cenered at 5,15,25 etc, plotted!^^ (so 1st bar is 0 to 10)
N=histc(scores,0:10:100) %grabs frequency of each bin and puts into row vect
bar(0:10:100,N,'r')
%rand draw from uniform dist from 0 to 1
%randn draw from normal curve
%random draw from different dist see help
%can seed rand num generators
rand('state',0); rand(1) 
rand(1)
rand('state',0); rand(1)
pause;
y=rand(1,100)*10+5
y=floor(rand(1,100)*10+6)
y=randn(1,1000)
close all;
figure;
subplot(2,1,1); %dim graph, position in figure
hist(y);
y2=y*5+8;
subplot(2,1,2);
hist(y2);

