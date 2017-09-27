function [peakwavelength,peakerror,rsquare] = findpeakgauss2(spectrum,origpeakidx,minInterval)
    %TRYthis for now, do half max later
%     if origpeakidx+valleyedge > length(spectrum)
%         lastOne = length(spectrum)
%     else
%         lastOne = origpeakidx+valleyedge
%     end
%     plot(spectrum(:,1),spectrum(:,2))
%     hold on;
%     minidx = minidx(spectrum(minidx,2) < (mean(spectrum(v))*spectrum(origpeakidx,2))
%     plot(spectrum(minidx,1),spectrum(minidx,2),'o')
%     minabove = minidx(minidx > origpeakidx)
%     minbelow = minidx(minidx < origpeakidx)
%     minInterval = [minbelow(end),minabove(1)]
    specToFit = spectrum(minInterval(1):minInterval(2),:)
    ft = fittype('fitfunction( x,p0,p1,a1,b1,c1 )')
    ft = 'p0 + x*p1 + a1*exp(-((x-b1)/c1)^2)'
    d = minInterval(2) - minInterval(1)
    [f,gof] = fit(specToFit(:,1),specToFit(:,2),ft,'Start',[minInterval(1),d/4 + minInterval(1),d/2 + minInterval(1),...
        3*d/4 + minInterval(1),minInterval(2)])%'gauss1')
    peakwavelength = f.b1
    peakerror = confint(f,0.95)
    peakerror = diff(peakerror(:,2))/2
    rsquare = gof.adjrsquare
end


