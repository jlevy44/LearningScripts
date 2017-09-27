%uiopen('/Users/JoshuaLevy/Desktop/ClassesSpring2017/111B/Labs/OPT/OPT.xlsx',1)
OPT = table2cell(readtable('/Users/JoshuaLevy/Desktop/ClassesSpring2017/111B/Labs/OPT/OPT.xlsx','Sheet',1))
OPTS1 = table2cell(readtable('/Users/JoshuaLevy/Desktop/ClassesSpring2017/111B/Labs/OPT/OPT.xlsx','Sheet',2))
Rb85Positive = cellfun(@str2num,OPT(5:10,1:2))
Rb85Negative = cellfun(@str2num,[OPT(5:10,1) OPT(5:10,3)])
Rb87Positive = cellfun(@str2num,[OPT(5:13,4:5)])
Rb87Negative = cellfun(@str2num,[OPT(5:12,4) OPT(5:12,6)])
Rb85PosErr =  cellfun(@str2num,OPTS1(4:8,2))
Rb85NegErr =  cellfun(@str2num,OPTS1(4:8,3))
Rb87PosErr =  cellfun(@str2num,OPTS1(4:8,4))
Rb87NegErr =  cellfun(@str2num,OPTS1(4:8,5))
stdRb85Pos = std(Rb85PosErr)
stdRb85Neg = std(Rb85NegErr)
stdRb87Pos = std(Rb87PosErr)
stdRb87Neg = std(Rb87NegErr)
deltai = [stdRb85Pos;stdRb85Neg;stdRb87Pos;stdRb87Neg]
figure; hold on;
errorbar(Rb85Positive(:,2),Rb85Positive(:,1),ones(size(Rb85Positive(:,1)))*deltai(1),'.','horizontal')
errorbar(Rb85Negative(:,2),Rb85Negative(:,1),ones(size(Rb85Negative(:,1)))*deltai(1),'.','horizontal')
errorbar(Rb87Positive(:,2),Rb87Positive(:,1),ones(size(Rb87Positive(:,1)))*deltai(1),'.','horizontal')
errorbar(Rb87Negative(:,2),Rb87Negative(:,1),ones(size(Rb87Negative(:,1)))*deltai(1),'.','horizontal')
% plot(Rb85Positive(:,2),Rb85Positive(:,1),'.')
% plot(Rb85Negative(:,2),Rb85Negative(:,1),'.')
% plot(Rb87Positive(:,2),Rb87Positive(:,1),'.')
% plot(Rb87Negative(:,2),Rb87Negative(:,1),'.')
xlabel('Current (A)')
ylabel('Frequency (MHz)')
title('Plot of Resonance Points')
% legend('Rb-85 Positive Polarity Resonance Points','Rb-85 Reverse Polarity Resonance Points','Rb-87 Positive Polarity Resonance Points','Rb-87 Reverse Polarity Resonance Points' )
plot(-0.0936,0,'o')
legend('Rb-85 Positive Polarity Resonance Points','Rb-85 Reverse Polarity Resonance Points','Rb-87 Positive Polarity Resonance Points','Rb-87 Reverse Polarity Resonance Points','Zero Field Resonance' )
[p1,p2,p3,p4] = deal(polyfit(Rb85Positive(:,2),Rb85Positive(:,1),1),polyfit(Rb85Negative(:,2),Rb85Negative(:,1),1),polyfit(Rb87Positive(:,2),Rb87Positive(:,1),1),polyfit(Rb87Negative(:,2),Rb87Negative(:,1),1))
functions = {@(x)p1(1)*x+p1(2);@(x)p2(1)*x+p2(2);@(x)p3(1)*x+p3(2);@(x)p4(1)*x+p4(2)}
deltaf1 = sqrt(sum((Rb85Positive(:,1)-arrayfun(@(x)functions{1}(x),Rb85Positive(:,2))).^2)/(4))
deltaf2 = sqrt(sum((Rb85Positive(:,1)-arrayfun(@(x)functions{1}(x),Rb85Positive(:,2))).^2)/4)
deltaf3 = sqrt(sum((Rb87Positive(:,1)-arrayfun(@(x)functions{3}(x),Rb87Positive(:,2))).^2)/7)
deltaf4 = sqrt(sum((Rb87Negative(:,1)-arrayfun(@(x)functions{4}(x),Rb87Negative(:,2))).^2)/6)

Delta1 = 6*sum(Rb85Positive(:,2).^2)-sum(Rb85Positive(:,2))^2
deltaM1 = deltaf1*sqrt(6/Delta1)
deltaB1 = deltaf1*sqrt(sum(Rb85Positive(:,2).^2)/Delta1)
Delta2 = 6*sum(Rb85Negative(:,2).^2)-sum(Rb85Negative(:,2))^2
deltaM2 = deltaf2*sqrt(6/Delta2)
deltaB2 = deltaf2*sqrt(sum(Rb85Negative(:,2).^2)/Delta2)
Delta3 = 9*sum(Rb87Positive(:,2).^2)-sum(Rb87Positive(:,2))^2
deltaM3 = deltaf3*sqrt(6/Delta3)
deltaB3 = deltaf3*sqrt(sum(Rb87Positive(:,2).^2)/Delta3)
Delta4 = 8*sum(Rb87Negative(:,2).^2)-sum(Rb87Negative(:,2))^2
deltaM4 = deltaf4*sqrt(6/Delta4)
deltaB4 = deltaf4*sqrt(sum(Rb87Negative(:,2).^2)/Delta4)
plot([0 1.5],arrayfun(@(x)functions{1}(x),[0 1.5]))
plot([0 1.5],arrayfun(@(x)functions{3}(x),[0 1.5]))
plot([-2 0],arrayfun(@(x)functions{2}(x),[-2 0]))
plot([-2 0],arrayfun(@(x)functions{4}(x),[-2 0]))

% calculate chisq
disp([ num2str(roundsd(stdRb85Pos,4)) ' ' num2str(roundsd(stdRb85Neg,4)) ' ' num2str(roundsd(stdRb87Pos,4)) ' ' num2str(roundsd(stdRb87Neg,4))])
[p12,p22,p32,p42] = deal(polyfit(Rb85Positive(:,1),Rb85Positive(:,2),1),polyfit(Rb85Negative(:,1),Rb85Negative(:,2),1),polyfit(Rb87Positive(:,1),Rb87Positive(:,2),1),polyfit(Rb87Negative(:,1),Rb87Negative(:,2),1))
functions2 = {@(x)p12(1)*x+p12(2);@(x)p22(1)*x+p22(2);@(x)p32(1)*x+p32(2);@(x)p42(1)*x+p42(2)}
%reduced ChiSq for inverted model, df = n-2 because 2 fit parameters
chisq = [sum((Rb85Positive(:,2)-arrayfun(@(x)functions2{1}(x),Rb85Positive(:,1))).^2)/stdRb85Pos^2/4;...
sum((Rb85Negative(:,2)-arrayfun(@(x)functions2{2}(x),Rb85Negative(:,1))).^2)/stdRb85Neg^2/4;...
sum((Rb87Positive(:,2)-arrayfun(@(x)functions2{3}(x),Rb87Positive(:,1))).^2)/stdRb87Pos^2/7;...
sum((Rb87Negative(:,2)-arrayfun(@(x)functions2{4}(x),Rb87Negative(:,1))).^2)/stdRb87Neg^2/6]
% r-square values 
rsq = [rsquare(Rb85Positive(:,2),arrayfun(@(x)functions2{1}(x),Rb85Positive(:,1)));...
rsquare(Rb85Negative(:,2),arrayfun(@(x)functions2{2}(x),Rb85Negative(:,1)));...
rsquare(Rb87Positive(:,2),arrayfun(@(x)functions2{3}(x),Rb87Positive(:,1)));...
rsquare(Rb87Negative(:,2),arrayfun(@(x)functions2{4}(x),Rb87Negative(:,1)))]
stats1 = arrayfun(@(x)roundsd(x,4),[chisq rsq])

slopes = [[p1(1) deltaM1];[p2(1) deltaM2];[p3(1) deltaM3];[p4(1) deltaM4]]
p3(1)/p1(1), p4(1)/p2(1)
intercepts = [[p1(2) deltaB1];[p2(2) deltaB2];[p3(2) deltaB3];[p4(2) deltaB4]]
% 2 and 4 column use equation Bh-Be, first and third use Bh+Be

% residual plots
figure; 
subplot(2,1,1)
hold on;
ylabel('Residual Current (A)')
xlabel('RF Frequency (MHz)')
title('Residual Plot of Resonance Points')
plot(Rb85Positive(:,1),Rb85Positive(:,2)-arrayfun(@(x)functions2{1}(x),Rb85Positive(:,1)),'*')
plot(Rb85Negative(:,1),Rb85Negative(:,2)-arrayfun(@(x)functions2{2}(x),Rb85Negative(:,1)),'*')
plot(Rb87Positive(:,1),Rb87Positive(:,2)-arrayfun(@(x)functions2{3}(x),Rb87Positive(:,1)),'*')
plot(Rb87Negative(:,1),Rb87Negative(:,2)-arrayfun(@(x)functions2{4}(x),Rb87Negative(:,1)),'*')
legend('Rb-85 Positive Polarity Resonance Points','Rb-85 Reverse Polarity Resonance Points','Rb-87 Positive Polarity Resonance Points','Rb-87 Reverse Polarity Resonance Points' )
subplot(2,1,2)
hold on;
% plot(Rb85Positive(:,1),Rb85Positive(:,2),'*')
% plot(Rb85Negative(:,1),Rb85Negative(:,2),'*')
% plot(Rb87Positive(:,1),Rb87Positive(:,2),'*')
% plot(Rb87Negative(:,1),Rb87Negative(:,2),'*')
errorbar(Rb85Positive(:,1),Rb85Positive(:,2),ones(size(Rb85Positive(:,1)))*deltai(1),'.','horizontal')
errorbar(Rb85Negative(:,1),Rb85Negative(:,2),ones(size(Rb85Negative(:,1)))*deltai(1),'.','horizontal')
errorbar(Rb87Positive(:,1),Rb87Positive(:,2),ones(size(Rb87Positive(:,1)))*deltai(1),'.','horizontal')
errorbar(Rb87Negative(:,1),Rb87Negative(:,2),ones(size(Rb87Negative(:,1)))*deltai(1),'.','horizontal')
ylabel('Residual Current (A)')
xlabel('RF Frequency (MHz)')
title('Plot of Resonance Points')
legend('Rb-85 Positive Polarity Resonance Points','Rb-85 Reverse Polarity Resonance Points','Rb-87 Positive Polarity Resonance Points','Rb-87 Reverse Polarity Resonance Points' )
plot([0 5],arrayfun(@(x)functions2{1}(x),[0 5]))
plot([0 5],arrayfun(@(x)functions2{3}(x),[0 5]))
plot([0 5],arrayfun(@(x)functions2{2}(x),[0 5]))
plot([0 5],arrayfun(@(x)functions2{4}(x),[0 5]))

newDeltai = roundsd(deltai.*(chisq.^(1/2)),4)
spins = arrayfun(@(x)2.799*135*0.9*10^(-2)/abs(x)/0.275/2 - 0.5,slopes(:,1))
spinError = arrayfun(@abs,slopes(:,2).*spins.*slopes(:,1).^(-1))
[spins spinError]

spins2 = arrayfun(@(x)round(x*2)/2,spins)

Be = arrayfun(@abs,intercepts(:,1).*arrayfun(@(x)2*x+1,spins2)/2.799) %in gauss
Be_error = intercepts(:,2).*arrayfun(@(x)2*x+1,spins2)/2.799

figure;
hold on;
xlabel('Earth/External Magnetic Field (not applied field) (gauss)')
title('Earth/External Magnetic Field and Error')
ylim([0 5])
set(gca,'YTick',[])
for i=1:4
    errorbar(Be(i),(5-i),Be_error(i),'.','horizontal')
end
legend('Rb-85 Positive Polarity Resonance Points','Rb-85 Reverse Polarity Resonance Points','Rb-87 Positive Polarity Resonance Points','Rb-87 Reverse Polarity Resonance Points' )

figure;
temperatureData = [32.2	3	0.4
35.9	3.2	0.4
37.2	3.6	0.4
39	3.6	0.4
39.5	3.7	0.4
41.5	3.8	0.4
44.3	4	0.4]
errorbar(temperatureData(:,1),temperatureData(:,2),temperatureData(:,3),'o')
hold on;
p = polyfit(temperatureData(:,1), temperatureData(:,2),1)
rsqTemp = 1-(sum((temperatureData(:,2)-polyval(polyfit(temperatureData(:,1), temperatureData(:,2),1),temperatureData(:,1))).^2)/((length(temperatureData(:,2)-1)*var(temperatureData(:,2)))))
plot(temperatureData(:,1),polyval(p,temperatureData(:,1)),'r')
title('Temperature Dependence of Signal Strength of 85Rb Photodetector Output Over Interval [32,45] Celsius')
xlabel('Temperature (Celsius)')
ylabel('Signal Strength (Divisions on Oscilloscope)')
legend('Observed Data Points','Best Fit Line')