% analysis hydrogen
H = [importdata('/Users/JoshuaLevy/Desktop/ClassesSpring2017/111B/Labs/Atomic Physics/Data/H_1_Speed20.dat');...
    importdata('/Users/JoshuaLevy/Desktop/ClassesSpring2017/111B/Labs/Atomic Physics/Data/H_2_Speed20.dat')]
Hg = [importdata('/Users/JoshuaLevy/Desktop/ClassesSpring2017/111B/Labs/Atomic Physics/Data/Hg1Speed20.dat');...
    importdata('/Users/JoshuaLevy/Desktop/ClassesSpring2017/111B/Labs/Atomic Physics/Data/Hg2Speed20.dat')]
H(:,2) = H(:,2) - min(H(:,2))
Hg(:,2) = Hg(:,2) - min(Hg(:,2))
figure;
[~,semipeaksH] = findpeaks(H(:,2),'MinPeakHeight',0.6,'MinPeakDistance',20)
[~,semipeaksHg] = findpeaks(Hg(:,2),'MinPeakHeight',0.51)
[~,semipeaksHg2] = findpeaks(Hg(Hg(:,1)>6120,2),'MinPeakHeight',0.01)
Hg2 = Hg(Hg(:,1)>6120,1)
Hg2peakwavelength = Hg2(semipeaksHg2)
semipeaksHg = [semipeaksHg;find(Hg(:,1)==Hg2peakwavelength)]
semipeaksH = [semipeaksH(1:4);semipeaksH(6:end)]

H(semipeaksH,1)
plot(Hg(:,1),Hg(:,2))
plot(Hg(semipeaksHg,1),Hg(semipeaksHg,2),'*')
[peakHg,errHg,rsqHg] = arrayfun(@(x)findpeakgauss(Hg,x),semipeaksHg)


figure;
Hg(semipeaksHg,1)
plot(H(:,1),H(:,2))
plot(H(semipeaksH,1),H(semipeaksH,2),'*')
[peakH,errH,rsqH] = arrayfun(@(x)findpeakgauss(H,x),semipeaksH)




% calibrate mercury
correctHg = [4046.56,4358.33,5460.74,5769.60,5790.66]' %,6149.50
peakHg = peakHg(2:end-1)
errHg = errHg(2:end-1)
weights = errHg.^(-2)
[calibrationLine,gof]=wpolyfit(correctHg,peakHg,1,weights)
calibration2 = @(x) x*calibrationLine(1) + calibrationLine(2)
calibration1 = @(x) x/calibrationLine(1) - calibrationLine(2)/calibrationLine(1)

delta = sum(weights)*sum(weights.*peakHg.^2)-(sum(weights.*peakHg))^2
db = sqrt(sum(weights.* peakHg .^2)/delta)
dm = sqrt(sum(weights)/delta)
db = calibrationLine(2)/calibrationLine(1)*sqrt((db/calibrationLine(2))^2 + (dm/calibrationLine(1))^2)
dm = dm/calibrationLine(1)


figure;
plot(peakHg,correctHg,'o')
hold on;
errorbar(peakHg,correctHg,errHg.^(-2))
plot([peakHg(1) peakHg(end)],arrayfun(@(x)calibration1(x),[peakHg(1) peakHg(end)]))
sum(errHg.^(-2).*(arrayfun(@(x)calibration2(x),correctHg)-peakHg).^2)/(length(errHg) -1)


% fix Hydrogen values
peakH_fixed = arrayfun(@(x) calibration1(x),peakH)
errH_fixed = ((peakH*dm).^2 + calibrationLine(1)^(-2)*errH.^2 + (db)^2).^(1/2)
%errH_fixed = arrayfun(@(x,dx) errFix(x,dx),errH)
a=1
% compare to actual Hydrogen values
correctH = [3889.049,3970.072,4101.74,4340.47,4861.33,6562.72]'
%FINISH Later, add residual plot for mercury and hydrogen

% convert to vacuum
peakH_fixed = arrayfun(@(x) solveforvacuum(x),peakH_fixed)
errH_fixed = errH_fixed.*arrayfun(@(x) 1+6432.8*10^-8 + 2949810./(146*10^8 - (1/x)^2) + 25540/(41*10^8 - (1/x)^2), peakH_fixed)

% now plotting 1/n^2 vs 1/wavelength
n = 3:8;
y = fliplr((peakH_fixed.^(-1))')
x = n.^-2
%Q = 1/wavelength
errQ = correctH.^(-2).*errH_fixed
w = fliplr(errQ.^(-2))'
figure;
plot(x,y,'o')
p = wpolyfit(x,y,1,w); %find error in polyfit, need 95% confidence interval
delta = sum(w)*sum(w.*x.^2)-(sum(w.*x))^2
m = (sum(w)*sum(w.*x.* y)-sum(w.*x )*sum(w.*y) ) / delta
b = (sum(w.* x .^2 )*sum(w.*y)-sum(w.*x)*sum(w.*x.*y) ) / delta
db = sqrt(sum(w.* x .^2)/delta)
dm = sqrt(sum(w)/delta)

% finding R and series limit R/4, WHAT IS THE ERROR!!!
R = -p(1)
R2 = p(2)*4
Rd4 = p(2)
fprintf('R = %13.6e\n',R)
fprintf('R/4 *4 = %13.6e\n',R2)
fprintf('R = %13.6e\n',-m)
fprintf('R/4 *4 = %13.6e\n',b*4)
fprintf('d R = %13.6e\n',db)
fprintf('d R/4 = %13.6e\n',dm)

bestFit = @(x)Rd4-R*x

% is this model a good fit
residuals = arrayfun(@(i)bestFit(i),x)-y
hold on;
plot([x(1) x(end)],[bestFit(x(1)),bestFit(x(end))])
errorbar(x,y,fliplr(errQ),'o')
figure;
plot(x,residuals,'*')
chiSq = sum((residuals.^2).*w)
df = length(x)-1
reducedChiSq = chiSq/df
prob = (1-chi2cdf(chiSq,df))*100
% does it produce our intended result
R_actual = 10973731.6/1e10
Rd4_actual = R_actual/4
fprintf('R_actual = %13.6e\n',R_actual)
RerrInterval = [R-dm,R+dm]
SeriesLimitInterval = [Rd4-db,Rd4+db]
abs(Rd4_actual-Rd4) < db
abs(R_actual-R) < dm
(R - R_actual)/R_actual * 100
(Rd4_actual-Rd4)/Rd4 * 100
function final = solveforvacuum(initial)
syms x
final =  double(solve(initial == x/(1+6432.8*10^-8 + 2949810./(146*10^8 - (1/x)^2) + 25540/(41*10^8 - (1/x)^2)),x))%initial*(1+6432.8*10^-8 + 2949810./(146*10^8 - (1/initial)^2) + 25540/(41*10^8 - (1/initial)^2))
final = final(end)
% final2 = initial*(1+6432.8*10^-8 + 2949810./(146*10^8 - (1/initial)^2) + 25540/(41*10^8 - (1/initial)^2))
%  for i=1:10
%  final2 = initial*(1+6432.8*10^-8 + 2949810./(146*10^8 - (1/final)^2) + 25540/(41*10^8 - (1/final)^2))
%  end
%  (final-final2)/final*100
%  a=1
end
