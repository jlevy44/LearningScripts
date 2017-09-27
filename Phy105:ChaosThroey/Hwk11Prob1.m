% r=3.2
% x(1) = 0.01 
% for i = 1:199
%     x(i + 1) = r* x(i)* (1 - x(i)) 
% end;
% t=1:1:200 
% plot(t,x)

%     ListPlot[x, Joined ? > True, AxesLabel ? > {?t?, ?x?}]

r1=0:.02:2.8;
r=linspace(2.8,4,10000);
xS1=arrayfun(@fixedPoint,r1)
hold on;
plot(r1,xS1)
xS=arrayfun(@fixedPoint,r)
plot(r,xS)
[xa,R]=deal({});
for i=1:length(r)
    [xa{i},R{i}]=XA(r(i));
    plot(R{i},xa{i},'.','color','b')
end;
hold on;
axis([2.8 4.0 0 1])
% savefig('Phys105Fig1241')
pause;
axis([3.84 3.856 0.445 0.55])
% savefig('Phys105Fig1244')
pause;
figure;

r=2.8:0.1:4;
rZero=0:0.1:4;
xSZero=zeros(size(rZero));
xS=arrayfun(@fixedPoint,r);
xS2=zeros(size(xS));
xb=arrayfun(@XB,r);
xc=arrayfun(@XC,r);
plot(rZero,xSZero,'--.',r1,xS1,r,xS,r,xc,r,xb)
% savefig('Phys105Fig1240')

