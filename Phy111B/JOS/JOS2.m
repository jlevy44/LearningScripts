load('JOSDCGain50.mat')
I = Y/1000;
V = X/50;
[~,pk1] = findpeaks(smooth(smooth(I)),'MinPeakDistance',30)
[~,pk2] = findpeaks(smooth(smooth(-I)),'MinPeakDistance',30)
a = sort([1;pk1;pk2;length(V)])
lala = a
x = {}
y = {}
dydx = {}
x2 = {}
ffts = {}
min1 = []
max1 = []
subplot(2,1,1)
% [X,Y]=deal(Y,X)

for i=1:length(a)/2
    x = [x,X(a(2*i):a(2*i+1))]
    y = [y,Y(a(2*i):a(2*i+1))]
    x2 = [x2,X(a(2*i):a(2*i+1)-1)+diff(X(a(2*i):a(2*i+1)))/2]
    min1 = [min1 min(X(a(2*i):a(2*i+1)))]
    max1 = [max1 max(X(a(2*i):a(2*i+1)))]
    plot(X(a(2*i):a(2*i+1)),Y(a(2*i):a(2*i+1)),'--'); hold on
    
    %pause;
end


minf = min(min1)
maxf = max(max1)

xq = minf:(maxf-minf)/600:maxf
xq2 = xq(1:end-1)+diff(xq)/2
Yint = []
Ic = []
dtot = []
dtotErr = []
for i=1:length(x)
    [u,idx] = unique(x{i})
    Yint = [Yint;interp1(u,y{i}(idx),xq)]
end
plot(xq,mean(Yint))
pause;
figure;
plot(xq,mean(Yint))
y2 = mean(Yint)
xq22 = xq
y22 = y2
points = ginput(2)
actualpoint = []
for i=1:2
    [~,idx] = min(sqrt((xq'-points(i,1)).^2 + (y2'-points(i,2)).^2))
    actualpoint = [actualpoint; [xq(idx),y2(idx)]]
end
hold on;
plot(actualpoint(:,1),actualpoint(:,2),'o')
Ic = [Ic;abs(actualpoint(2,2)-actualpoint(1,2))/2]
plot(xq2,diff(y2)./diff(xq))
a3 = [xq2',(diff(y2)./diff(xq))']
a1 = a3(:,1); a2 = a3(:,2);
a3 = [a1(~isnan(a2)),a2(~isnan(a2))]
[f,gof] = fit(a3(:,1),a3(:,2),'gauss1')
plot(f)
pause;
hold off;
subplot(2,1,2)
%pause;
x = {}
y = {}
dydx = {}
x2 = {}
ffts = {}
min1 = []
max1 = []
% [X,Y]=deal(Y,X)
for i=2:length(a)/2
    x = [x,X(a(2*i-1):a(2*i))]
    y = [y,Y(a(2*i-1):a(2*i))]
    x2 = [x2,X(a(2*i-1):a(2*i)-1)+diff(X(a(2*i-1):a(2*i)))/2]
    min1 = [min1 min(X(a(2*i-1):a(2*i)))]
    max1 = [max1 max(X(a(2*i-1):a(2*i)))]
    plot(X(a(2*i-1):a(2*i)),Y(a(2*i-1):a(2*i)),'--'); hold on

    %pause;
end


minf = min(min1)
maxf = max(max1)

xq = minf:(maxf-minf)/600:maxf
xq2 = xq(1:end-1)+diff(xq)/2
Yint = []

dtot = []
dtotErr = []
for i=1:length(x)
    [u,idx] = unique(x{i})
    Yint = [Yint;interp1(u,y{i}(idx),xq)]
end
figure;
plot(xq,mean(Yint))
y2 = mean(Yint)
points = ginput(2)
actualpoint = []
for i=1:2
    [~,idx] = min(sqrt((xq'-points(i,1)).^2 + (y2'-points(i,2)).^2))
    actualpoint = [actualpoint; [xq(idx),y2(idx)]]
end
hold on
plot(actualpoint(:,1),actualpoint(:,2),'o')
Ic = [Ic;abs(actualpoint(2,2)-actualpoint(1,2))/2]
plot(xq2,diff(y2)./diff(xq))
a = [xq2',(diff(y2)./diff(xq))']
[f,gof] = fit(a(2:end-1,1),a(2:end-1,2),'gauss1')
plot(f)
hold off;
figure;
subplot(2,1,1)
plot(xq22,y22)
subplot(2,1,2)
plot(xq,y2)
figure;
for i=1:8
    subplot(4,2,i)
    plot(V(lala(i):lala(i+1)),I(lala(i):lala(i+1)))
    xlabel('Voltage (volts)')
    ylabel('Current (amps)')
    title('Subset of I-V Curve Data DC Effect')
end