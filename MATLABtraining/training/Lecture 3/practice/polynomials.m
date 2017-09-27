P=[1 0 -2] %represent 1x^2+0x?2=P(1)x^2+P(2)x+P(3)
r=roots(P) %second order poly, so should have 2 roots, if not r has 2 elements anyways
P=poly(r) %gets polynomial from roots

x0=3;
y0=polyval(P,x0) %y(3)=(3)^2 - 2 = 7

x=1:1:100 %low:interval:high
y=polyval(P,x)

X=[-1 0 2]; Y=[0 -1 3];
p2=polyfit(X,Y,2);
%2 is for second order that best fits points described by X and Y

plot(X,Y,'o', 'MarkerSize',10);
hold on;
x=-3:.01:3;
plot (x,polyval(p2,x), 'r--');
close 1;

%exercise
x=-4:0.1:4;
y=x.^2;
y=y+randn(size(y)); %generates noise around y, rand numb generator returns matrix size of y
plot(x,y,'Marker','.','MarkerSize',10);
hold on;
p2=polyfit(x,y,2); %fits a 2nd degree curve to the data
plot(x,polyval(p2,x),'r'); %plots the values of the curve with respect to x

%finding roots
x0=1
x=fzero('myfun',x0) %finds root of specified function in myfun.m, x0 is the initial point it checks

%minimize function over interval
xmin=fminbnd('myfun',-1,2)

xmin=fminsearch('myfun',0.5) %local minimum near 0.5

%can also make direct input arguement
x=fzero(@(x) (exp(x)+cos(x)-15), 1)
        %input     function     start checking
%for other optimizations, use linprog, quadprog,fmincon

xmin=fminbnd('myfun',-pi,pi)
%xmin=fminbnd(@(x) myfun(x),-pi,0)
x=-pi:.001:pi;
y=myfun(x);
figure;
plot(x,myfun(x));
[miny,minIndy] = min(y)
hold on;
indep=[xmin x(minIndy)];
dep=[myfun(xmin) miny];
plot(indep, dep, 'Marker','*','MarkerSize','20','LineStyle','none');
%p.21 figure out why this is not grabbing the true minimum!^^^
%^^this will just shoot out a local minimum, not a global
%fix above line plot!!!
disp(['minimum of y is approx. = ' num2str(miny) ' whose x val is ' ... 
    num2str(x(minIndy))])

%plot(x(minIndy),miny,'Marker','*','MarkerSize','20');
hold off;

%fix this code!!!