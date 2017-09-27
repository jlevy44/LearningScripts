load('JOSACGain500.mat')
[~,pk1] = findpeaks(smooth(smooth(Y)),'MinPeakDistance',30)
[~,pk2] = findpeaks(smooth(smooth(-Y)),'MinPeakDistance',30)
a = sort([1;pk1;pk2;length(X)])
x = {}
y = {}
dydx = {}
x2 = {}
ffts = {}
min1 = []
max1 = []
% [X,Y]=deal(Y,X)
for i=1:length(a)-1
    x = [x,X(a(i):a(i+1))]
    y = [y,Y(a(i):a(i+1))]
    x2 = [x2,X(a(i):a(i+1)-1)+diff(X(a(i):a(i+1)))/2]
    dydx = [dydx,diff(Y(a(i):a(i+1)))./diff(X(a(i):a(i+1)))]
    min1 = [min1 min(X(a(i):a(i+1)))]
    max1 = [max1 max(X(a(i):a(i+1)))]
    plot(X(a(i):a(i+1)),Y(a(i):a(i+1)))
    %pause;
    plot(x2{i},dydx{i})
    %findpeaks(dydx{i},'MinPeakProminence',50,'MinPeakDistance',10)
    ffts = [ffts;fft(dydx{i}(~isinf(dydx{i})))]

    %pause;
end


minf = min(min1)
maxf = max(max1)

xq = minf:(maxf-minf)/199:maxf
xq2 = xq(1:end-1)+diff(xq)/2

Yint = []

dtot = []
dtotErr = []
rsq = []
for i=1:length(x)
    [u,idx] = unique(x{i})
    Yint = [Yint;interp1(u,y{i}(idx),xq)]
    subplot(2,1,1)
    plot(xq,Yint(i,:))
    title('Josephson I-V Curve for Single Sweep (Accounts for Hysteresis)')
    xlabel('Horizontal Scope Voltage (volts)')
    ylabel('Vertical Scope Voltage (volts)')
    dydx2 = diff(Yint(i,:))./diff(xq)
    subplot(2,1,2)
    plot(xq2,dydx2)
    [~,idx] = findpeaks(dydx2,'MinPeakDistance',10,'MinPeakProminence',30)
    %[~,idx2] = findpeaks(-dydx2,'MinPeakDistance',10,'MinPeakProminence',30)
    hold on;
    plot(xq2(idx),dydx2(idx),'o')
    %plot(xq2(idx2),dydx2(idx2),'*')
    findDist = []
    findDisterr = []
    for j=1:length(idx)-2
        interval = [round(mean(idx(j:j+1))) round(mean(idx(j+1:j+2)))]
        plot(xq2(interval),smooth(dydx2(interval),'sgolay'),'*')
        options = fitoptions('gauss1');
%         options.Robust = 'LAR';
        [f,gof] = fit(xq2(interval(1):interval(2))',smooth(dydx2(interval(1):interval(2))','sgolay'),'gauss1',options)
        rsq = [rsq; gof.adjrsquare]
        ci = diff(confint(f,0.95))/2
        plot(f)
        findDist = [findDist f.b1-f.c1 f.b1+f.c1]
        findDisterr = [findDisterr sqrt(ci(2)^2 + ci(3)^2) sqrt(ci(2)^2 + ci(3)^2)]
            xlabel('Horizontal Scope Voltage (volts)')
    ylabel('dVv/dVh')
    a=1
        %pause
        
    end
    findDist = findDist(2:end)
    findDisterr = findDisterr(2:end)
    plot(findDist,zeros(length(findDist),1),'o')
    d = diff(findDist)
    dErr = sqrt(findDisterr(1:end-1).^2 + findDisterr(2:end).^2)
    d = d(1:2:end)
    dErr = dErr(1:2:end)
    hold off;
    dtot = [dtot,d]
    dtotErr = [dtotErr,dErr]
    %pause
end
rsqfinal = mean(rsq)
dfin = sum(dtot./(dtotErr.^2))/sum((dtotErr.^(-2)))
dfinErr = 1/sqrt(sum((dtotErr.^(-2))))%sqrt(sum(dtotErr.^2))/length(dtotErr)
va = .000515
dva = .0000005
vb = 0.260
dvb = .0005
G = vb/va
dG = sqrt((1/va)^2*dvb^2+(vb/va^2)*dva^2)
f = 22620
df = 5
dfin = dfin*10^6
dfinErr = dfinErr*10^6
jos = f*G/dfin
josErr = sqrt((f*G/dfin^2)^2*dfinErr^2+(G/dfin)^2*df^2+(f/dfin)^2*dG^2)
relErr = abs(jos-483.60)/483.60*100
percent = jos/483.60

%figure
%plot(xq,mean(Yint))
%c = mean(Yint)

%plot(xq(1:end-1)+diff(xq)/2,diff(c)./diff(xq))
figure;

for i=1:length(a)-1
    subplot(4,2,i)
    plot(X(a(i):a(i+1)),Y(a(i):a(i+1)))

end
