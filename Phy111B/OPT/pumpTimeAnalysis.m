load('positionpumprelax.mat')
rx = (calibrationpt(2,:)-calibrationpt(1,:))/sqrt(dot(calibrationpt(2,:)-calibrationpt(1,:),calibrationpt(2,:)-calibrationpt(1,:)))
ry = (calibrationpt(3,:)-calibrationpt(1,:))/sqrt(dot(calibrationpt(3,:)-calibrationpt(1,:),calibrationpt(3,:)-calibrationpt(1,:)))
x1 = calibrationpt(1,:)
relativePump = []
relativeRelax = []
secondsConv = 1.5/sqrt(dot(calibrationpt(2,:)-calibrationpt(1,:),calibrationpt(2,:)-calibrationpt(1,:)))
voltsConv = 0.3/sqrt(dot(calibrationpt(3,:)-calibrationpt(1,:),calibrationpt(3,:)-calibrationpt(1,:)))
for i=1:length(positionPump)
    relativePump = [relativePump;dot(positionPump(i,:)-x1,rx)*secondsConv dot(positionPump(i,:)-x1,ry)*voltsConv]
end

for i=1:length(positionRelax)
    relativeRelax = [relativeRelax;dot(positionRelax(i,:)-x1,rx)*secondsConv dot(positionRelax(i,:)-x1,ry)*voltsConv]
end
figure;
plot(relativePump(:,1),relativePump(:,2),'o',relativeRelax(:,1),relativeRelax(:,2),'*')
title('Optical Pumping and Relaxation Data Points')
xlabel('Time Elapsed (Seconds)')
ylabel('Signal (Voltage)')
legend('Pumping','Relaxation')

relativePump(:,1) = relativePump(:,1) - min(relativePump(:,1))
relativePump(:,2) = relativePump(:,2) - min(relativePump(:,2))
relativeRelax(:,1) = relativeRelax(:,1) - min(relativeRelax(:,1))
relativeRelax(:,2) = relativeRelax(:,2) - min(relativeRelax(:,2))
figure;
hold on
subplot(2,1,1)
plot(relativePump(:,1),relativePump(:,2),'o')
[f1,gof1] = fit(relativePump(:,1),relativePump(:,2),'a*(1-exp(-x/T))')
plot(f1,relativePump(:,1),relativePump(:,2))
hold on
plot([0 f1.T f1.T],[f1.a*(1-exp(-1)) f1.a*(1-exp(-1)) 0],'--')
title('Pumping Curves')
xlabel('Time Elapsed Since Pumping Start (Seconds)')
ylabel('Signal (Voltage)')
legend('Transformed Pumping Data Points','Pumping Fit Line', 'Pumping Time Cutoff Point')
subplot(2,1,2)
[f2,gof2] = fit(relativeRelax(:,1),relativeRelax(:,2),'a*exp(-x/T)')
plot(relativeRelax(:,1),relativeRelax(:,2),'o')
plot(f2,relativeRelax(:,1),relativeRelax(:,2))
hold on;
plot([0 f2.T f2.T],[f2.a*exp(-1) f2.a*exp(-1) 0],'--')
title('Relaxation Curves')
xlabel('Time Elapsed Since Relaxation Start (Seconds)')
ylabel('Signal (Voltage)')
legend('Transformed Relaxation Data Points','Relaxation Fit Line', 'Relaxation Time Cutoff Point')
gof1.adjrsquare
gof1.dfe
gof2.adjrsquare
gof2.dfe
