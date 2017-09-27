load('JOSACGain500.mat')
[~,pk1] = findpeaks(smooth(smooth(Y)),'MinPeakDistance',30)
[~,pk2] = findpeaks(smooth(smooth(-Y)),'MinPeakDistance',30)
a = sort([1;pk1;pk2;length(X)])
x = {}
y = {}
for i=1:length(a)-1:
    x = [x,X(a(i):a(i+1))]
    y = [y,Y(a(i):a(i+1))]
end