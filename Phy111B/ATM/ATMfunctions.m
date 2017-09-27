function [peakwavelength,peakstd] = findpeakgauss(spectrum,origpeakidx)
    [~,minidx] = findpeaks(spectrum(origpeakidx-50:origpeakidx+50,2)*-1,'minPeakDistance',15)
    minidx = origpeakidx - 50 + minidx
    print minidx
end


