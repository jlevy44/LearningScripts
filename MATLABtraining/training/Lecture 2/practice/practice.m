%can put multiple commands on one line
x=1:10; y=(x-5).^2; %plot(x,y);
%^^^ why is there a dot when power raised
clc;
clear all;

x=rand(50,1); %column vector 50 elements
inds=find(x<0.1);
y=x(inds) %assigns x vector element values <.1
x(inds)=-x(inds) % makes chosen values negative in vector

% finish review

%creating functions must have function declaration
%function [avg,sd,range]=stats(x)
%avg=mean(x);
%sd=std(x);
%range=[min(x); max(x)];

%stats(x) fix this

help size;

a=zeros(2,4,8) %n-dimensional matrices...
help zeros;
D=size(a)
[m,n]=size(a)
[x,y,z]=size(a)
help varargin;

clc;
help hold;
hold on;
plotSin(5)
help linspace
help .
clc;
%if 1 com1 end or if 1 com1 else com2 end
%if 1 com1 elseif 2 com2 else com3 end
start= clock;
e=zeros(100,1);
progress=zeros(100,1);
for m=1:100
    x=zeros(100,1);
    y=0;
    z=0;
    for n=1:100
        x(n)=5*(rand(1)-0.5);
        while and(x(n)<=2.4, x(n)>-2.4) 
            x(n)=(rand(1)-0.5)*5;
            if or(x(n)>1,x(n)<-1)
                x(n)
            end
            y=y+1;
        end   
        z=z+1;
    end
    e(m)=y-z;
    p=clock;
    progress(m)=timeElapsed(start,p);
    %a=1:100;
    %a(m+1:100)=0;
    %plot(progress,a)
end 
e
avg= mean(e);
end1= clock
elapsedTime=num2str(timeElapsed(start,end1));
figure;
plot(progress,e);
figure;
plot(progress,1:100);
figure;
plot3(1:100,e,progress);

clc;
%figure out how to concatenate this
%a=[1:100,e,progress]
%turn to matrix
disp (['On average, ' num2str(avg) ' numbers that were randomly ' ... 
    'generated did not match the loop criteria']);
disp(['It took ' elapsedTime ' seconds to make these computations']);

%new exercise on new practice....