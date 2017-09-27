function [peakwavelength,peakerror,rsq] = findpeakgauss(spectrum,origpeakidx)
    if origpeakidx+50 > length(spectrum)
        lastOne = length(spectrum)
    else
        lastOne = origpeakidx+50
    end
    [~,minidx] = findpeaks(smooth(spectrum(origpeakidx-50:lastOne,2))*-1,'minPeakDistance',3)
    minidx = origpeakidx - 50 + minidx
    plot(spectrum(:,1),spectrum(:,2))
    hold on;
    minidx = minidx(spectrum(minidx,2) < 0.5*spectrum(origpeakidx,2))
    minabove = minidx(minidx > origpeakidx)
    minbelow = minidx(minidx < origpeakidx)
    if length(minabove) == 0
        minabove = [length(spectrum)]
    end
    if length(minbelow) == 0
        minbelow = [origpeakidx - 20]
    end
    minInterval = [minbelow(end),minabove(1)]
    specToFit = spectrum(minInterval(1):minInterval(2),:)
    plot(spectrum(minInterval(:),1),spectrum(minInterval(:),2),'o')
    [f,gof] = fit(specToFit(:,1),specToFit(:,2),'gauss1')
    peakwavelength = f.b1
    peakerror = confint(f,0.95)
    peakerror = diff(peakerror(:,2))/2
    rsq = gof.adjrsquare
end


