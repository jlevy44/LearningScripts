h1 = histogram(peak,30);  
x = h1.BinEdges(1:end-1)+mean(diff(h1.BinEdges))/2;
y = h1.Values;
err = sqrt(h1.Values);
hold on;
plot(x,y,'o');
hold off;
%f = fit(x,y,1/sqrt(2*s^2*pi)*exp(-((x-m)/s)^2))
cftool