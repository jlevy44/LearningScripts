% create image profiles for all diffraction images
% generate data structure for zeeman effect
averageStructure = containers.Map({'NoSplit','Split1','Split2'},{{'image','B'},{'image','B'},{'image','B'}})
zeemanProfile = containers.Map({'Good','Bad'},{containers.Map({'Red1half','Red2quarter','Red3halfspec','Yellow1halfspec'},{averageStructure,averageStructure,averageStructure,averageStructure}),containers.Map({'Red1quarter','Red2quarter','Yellow1quarter'},{averageStructure,averageStructure,averageStructure})})
analysesGood = {'Red1halfGood'	'Red2quarterGood'	'Red3halfspecGood'	'Red1quarterBad'	'Red2quarterBad'	'Yellow1halfspecGood'	'Yellow1quarterBad'}
% read data table
ATMData = table2cell(readtable('/Users/JoshuaLevy/Desktop/ClassesSpring2017/111B/Labs/Atomic Physics/Data/ATM.xlsx'))
a=1
% ignore above for now, consider 2 photos
mainfolder = '/Users/JoshuaLevy/Desktop/ClassesSpring2017/111B/Labs/Atomic Physics/Data/ATM Images-3/'
analyses = {ATMData{1,:}}
ZeemanTotals = {}
theta = 15
R = [cos(theta) sin(theta);-sin(theta) cos(theta)]
output = {'Analysis' 'Run' 'Mean Magnetic Field (Gauss)' 'B Error (Gauss)' 'Order Change' 'Order Change Error' 'Splitting Ratio (cm^-1 / Gauss)' 'Splitting Ratio Error(cm^-1 / Gauss)' 'Bohr Magneton (J/G)' 'Bohr Magneton Error (J/G)'}'
for j = 1:length(analyses)%length(analyses)-2:length(analyses)
    photos = {'NoSplit.bmp','Split1.bmp','Split2.bmp'}
    Bfield = {ATMData(5:14,j),ATMData(16:25,j)}
    diffpeakFinal = cell(1,3)
    diffpeakerrFinal = cell(1,3)
    maxidxNoSplit = []
    
    if strcmp(analyses{j}, 'Red2quarterGood')
        photos = {'NoSplit.bmp','Split1.bmp'}
        Bfield = {ATMData(5:14,j)}
        diffpeakFinal = cell(1,2)
        diffpeakerrFinal = cell(1,2)
    end
    order = str2num(cell2mat({ATMData{3,j}}))
    color = {ATMData{2,j}}
    Bstd = []
    Bmean = []
    Itot = {}
    avgrsquare = [0 0 0.71]
    linefail = 0
    if j<=3
        while(any(avgrsquare <= 0.6))
            avgrsquare = [0 0 0.71]
            c = {}
            smoothC = {}
            for i=1:length(photos)
                %profileVector = ginput(2)
                photo = [mainfolder,analyses{j},'/',photos{i}]
                I = histeq(imadjust(imread(photo)));
                Itot = [Itot, I]
                imshow(photo);
                if i==1
                    profileVectorOrig = ginput(2) % click on inside circle first
                    origin = profileVectorOrig(1,:)
                    %p = polyfit(profileVectorOrig(:,1),profileVectorOrig(:,2));
                    m = diff(profileVectorOrig(:,2))/diff(profileVectorOrig(:,1));
                    b = profileVectorOrig(1,2) - m*profileVectorOrig(1,1)
                    line = [linspace(min(profileVectorOrig(:,1)),max(profileVectorOrig(:,1)),1000)',arrayfun(@(x)x*m+b,linspace(min(profileVectorOrig(:,1)),max(profileVectorOrig(:,1)),1000)')]
                    hold on;
                    plot(line(:,1),line(:,2))
                    outsideCircle = ginput(1);
                    distance = (line-outsideCircle).^2;
                    [~,mindistanceidx] = min((distance(:,1) + distance(:,2)).^(1/2))
                    profileVectorOrig(1,:) = line(mindistanceidx,:);
                    plot(profileVectorOrig(:,1),profileVectorOrig(:,2),'o')
                    a=1
                end
                
            end
            figure
            hold on
            for i = 1:length(photos)
                I = Itot{i};
                % if order = 1/2 or 1/4,
                intensity = improfile(I,profileVectorOrig(:,1),profileVectorOrig(:,2));
                %round(mean(diff(findpeaks(smooth(smooth(intensity))))))
                [~,ylower] = envelope(intensity,30,'peak')
                intensity = intensity - ylower
                c = [c,intensity];
                smoothInt = smooth(smooth(smooth(intensity))); % try different smoothing algorithms
                smoothC = [smoothC,smoothInt];
                plot(smoothInt)
            end
            intervalGauss = ginput(2)
            intervalGauss = intervalGauss(:,1)
            for i = 1:length(photos)
                
                intensity = c{i}
                smoothInt = smooth(smooth(smooth(intensity)));
                figure;
                distance = 1:length(intensity);
                [~,minIdx] = findpeaks(-smoothInt);
                [~,maxIdx] = findpeaks(smoothInt);
                bounds = minIdx(minIdx >= intervalGauss(1))
                %bounds = bounds(bounds <= intervalGauss(2))
                if order == 0.5 && i~=1
                    bounds = bounds(1:5)
                    fitnum = 4
                end
                if i == 1
                    bounds = bounds(1:5)
                    fitnum = 4
                end
                if order == 0.25 && i~=1
                    bounds = bounds(1:9)
                    fitnum = 8
                end
                lowbound = bounds(1)
                highbound = bounds(end)
                maxBounds = maxIdx(maxIdx >= lowbound)
                maxBounds = maxBounds(maxBounds<= highbound)
                figure
                plot(distance(lowbound:highbound)',intensity(lowbound:highbound)-min(intensity(lowbound:highbound)))
                hold on
                plot(distance(lowbound:highbound)',smooth(smooth((intensity(lowbound:highbound)-min(intensity(lowbound:highbound))))))
                %ft = fitoptions('gauss4')
                [f,gof] = fit(distance(lowbound:highbound)',intensity(lowbound:highbound)-min(intensity(lowbound:highbound)),['gauss' num2str(fitnum)])%,'Start',maxBounds)
                peaks = [ f.b4 f.b3 f.b2 f.b1]'
                confinterval = confint(f,0.95)
                peakerror = abs(diff([ confinterval(:,11) confinterval(:,8) confinterval(:,5) confinterval(:,2)])/2)'
                if order == 0.25 && i~=1
                    peaks = [ f.b8 f.b7 f.b6 f.b5 f.b4 f.b3 f.b2 f.b1]'
                    peakerror = abs(diff([confinterval(:,23) confinterval(:,20) confinterval(:,17) confinterval(:,14) confinterval(:,11) confinterval(:,8) confinterval(:,5) confinterval(:,2)])/2)'
                end
                peakData = sortrows([peaks peakerror],1)
                peaks = peakData(:,1)'
                peakerror = peakData(:,2)'
                %[peaks,idxPk] = sort([f.b4 f.b3 f.b2 f.b1])
                plot(f)
                plotDist = arrayfun(@(x)round(x),peaks)
                plot(plotDist,intensity(plotDist),'o')
                rsquare = gof.adjrsquare
                %                 if i == 1
                %                     for k=1:4 % FIX Needs to be adjusted depending on the error, may need to use values from the first nosplit image
                %                         max1 = maxIdx(k+1)
                %                         min1 = minIdx(minIdx<max1)
                %                         min1 = min1(end)
                %                         min2 = minIdx(minIdx>max1)
                %                         min2 = min2(1)
                %                         maxidxNoSplit = [maxidxNoSplit,max1]
                %                         [peaks(k),peakerror(k),rsquare(k)] = findpeakgauss2([distance',smoothInt],max1,[min1,min2]) % modify, include both valley indexes and see in earlier code if can grab values from FWHM
                %                     end
                %                 end
                %                 if i > 1
                %                     for k=1:4 % FIX Needs to be adjusted depending on the error, may need to use values from the first nosplit image
                %                         firstMax = maxIdx(maxIdx > maxidxNoSplit(k+1))
                %                         max1 = firstMax(1)
                %                         min1 = minIdx(minIdx<max1)
                %                         min1 = min1(end)
                %                         min2 = minIdx(minIdx>max1)
                %                         min2 = min2(1)
                %                         maxidxNoSplit = [maxidxNoSplit,max1]
                %                         [peaks(k),peakerror(k),rsquare(k)] = findpeakgauss2([distance',smoothInt],max1,[min1,min2]) % modify, include both valley indexes and see in earlier code if can grab values from FWHM
                %                     end
                avgrsquare(i) = rsquare
                diffpeakFinal{i} = abs(diff(peaks))
                diffpeakerrFinal{i} = (peakerror(1:3).^2 + peakerror(2:4).^2).^(1/2)
                if order == 0.25 && i~=1
                    diffpeakerrFinal{i} = (peakerror(1:7).^2 + peakerror(2:8).^2).^(1/2)
                    %evenPeakDat =  diffpeakFinal{i}(2:2:length(diffpeakFinal{i}))
                    %evenPeakWeights = diffpeakerrFinal{i}(2:2:length(diffpeakerrFinal{i})).^(-2)
                    %oddPeakDat = diffpeakFinal{i}(1:2:length(diffpeakFinal{i}))
                    peakdiffdat = diffpeakFinal{i}
                    weights = diffpeakerrFinal{i}.^(-2)
                    diffpeakFinal{i} = []
                    diffpeakerrFinal{i} = []
                    for k=1:2:length(peakdiffdat)-1
                        diffpeakFinal{i} = [diffpeakFinal{i},sum(weights(k:k+1).*peakdiffdat(k:k+1))/sum(weights(k:k+1))]
                        diffpeakerrFinal{i} = [diffpeakerrFinal{i},1/sqrt(sum(weights(k:k+1)))]
                    end
                end
            end
            
            close all;
        end
        
    end
    if j>3
        c = {}
        for i=1:length(photos)
            %profileVector = ginput(2)
            photo = [mainfolder,analyses{j},'/',photos{i}]
            I = histeq(imadjust(imread(photo)));
            imshow(photo);
            if i==1
                if linefail == 0
                    profileVectorOrig = ginput(2) % click on inside circle first
                    origin = profileVectorOrig(1,:)
                    %p = polyfit(profileVectorOrig(:,1),profileVectorOrig(:,2));
                    m = diff(profileVectorOrig(:,2))/diff(profileVectorOrig(:,1));
                    b = profileVectorOrig(1,2) - m*profileVectorOrig(1,1)
                    line = [linspace(min(profileVectorOrig(:,1)),max(profileVectorOrig(:,1)),1000)',arrayfun(@(x)x*m+b,linspace(min(profileVectorOrig(:,1)),max(profileVectorOrig(:,1)),1000)')]
                    hold on;
                    plot(line(:,1),line(:,2))
                    outsideCircle = ginput(1);
                    distance = (line-outsideCircle).^2;
                    [~,mindistanceidx] = min((distance(:,1) + distance(:,2)).^(1/2))
                    profileVectorOrig(1,:) = line(mindistanceidx,:);
                end
                
                if linefail == 1
                    relative1 = profileVectorOrig(1,:)-origin
                    relative1 = relative1'
                    relative2 = profileVectorOrig(1,:)-origin
                    relative2 = relative2'
                    newrelative1 = R*relative1
                    newrelative2 = R*relative2
                    profileVectorOrig(1,:) = origin + newrelative1'
                    profileVectorOrig(2,:) = origin + newrelative2'
                end
                plot(profileVectorOrig(:,1),profileVectorOrig(:,2),'o')
            end
            % if order = 1/2 or 1/4,
            intensity = improfile(I,profileVectorOrig(:,1),profileVectorOrig(:,2));
            %round(mean(diff(findpeaks(smooth(smooth(intensity))))))
            [~,ylower] = envelope(intensity,30,'peak')
            intensity = intensity - ylower
            c = [c,intensity];
            smoothInt = smooth(smooth(smooth(intensity))); % try different smoothing algorithms
            smoothC = [smoothC,smoothInt];
            distance = 1:length(intensity);
            [~,minIdx] = findpeaks(-smoothInt);
            [~,maxIdx] = findpeaks(smoothInt);
            figure;
            plot(distance,smoothInt)
            hold on;
            plot(distance(maxIdx),smoothInt(maxIdx),'o')
            plot(distance(minIdx),smoothInt(minIdx),'o')
            figure;
            peakDistance = diff(distance(maxIdx))
            valleyDistance = diff(distance(minIdx))
            peaks = zeros(1,4);
            peakerror = zeros(1,4);
            rsquare = zeros(1,4);
            if i == 1
                for k=1:4 % FIX Needs to be adjusted depending on the error, may need to use values from the first nosplit image
                    max1 = maxIdx(k+1)
                    min1 = minIdx(minIdx<max1)
                    min1 = min1(end)
                    min2 = minIdx(minIdx>max1)
                    min2 = min2(1)
                    maxidxNoSplit = [maxidxNoSplit,max1]
                    [peaks(k),peakerror(k),rsquare(k)] = findpeakgauss2([distance',smoothInt],max1,[min1,min2]) % modify, include both valley indexes and see in earlier code if can grab values from FWHM
                end
            end
            if i > 1
                for k=1:4 % FIX Needs to be adjusted depending on the error, may need to use values from the first nosplit image
                    firstMax = maxIdx(maxIdx > maxidxNoSplit(k+1))
                    max1 = firstMax(1)
                    min1 = minIdx(minIdx<max1)
                    min1 = min1(end)
                    min2 = minIdx(minIdx>max1)
                    min2 = min2(1)
                    maxidxNoSplit = [maxidxNoSplit,max1]
                    [peaks(k),peakerror(k),rsquare(k)] = findpeakgauss2([distance',smoothInt],max1,[min1,min2]) % modify, include both valley indexes and see in earlier code if can grab values from FWHM
                    
                end
            end
            avgrsquare(i) = mean(rsquare)
            diffpeakFinal{i} = diff(peaks)
            diffpeakerrFinal{i} = (peakerror(1:3).^2 + peakerror(2:4).^2).^(1/2)
        end
        close all;
        if ~isempty(strfind('Bad',analyses{j}))
            avgrsquare = [1 1 1]
        end
        linefail = 0
        
    end
    %         figure;
    %     hold on;
    %         for i=1:length(smoothC)
    %             plot(smoothC{i})
    %         end
    %         for i = 1:length(c)
    %             plot(c{i})
    %         end
    a=1
    linefail = 0
    for i=1:length(photos)-1
        if or(i == 1,i==2)
            B = cellfun(@str2num,Bfield{i})
            Bmean = [Bmean;mean(B)]
            Berr = std(B)
            Bstd = [Bstd;Berr]
        end
        % example, need to do for all i, should approximately be order/2 or /4
        orderChange = diffpeakFinal{i+1}./diffpeakFinal{1} * 0.5
        orderErr = 0.5*diffpeakFinal{1}.^(-1).*sqrt(diffpeakerrFinal{i+1}.^2+(diffpeakerrFinal{1}.*diffpeakFinal{i+1}./diffpeakFinal{1}).^2)
        % ratio of energy level splitting to magnetic field cm^-1/gauss
        ratioSplit = orderChange/(2*0.811 * Bmean(i))
        ratioSplitErr = 1/(2*0.811*Bmean(i))*(orderErr.^2+(Bstd(i)*orderChange./Bmean(i)).^2).^(1/2)
        % may need to change if yellow; in J/T
        bohr = 1.986445*10.^(-25) * orderChange./(2*0.00811 * Bmean(i))
        bohrErr = 1.986445*10.^(-25)/(2*0.00811*Bmean(i))*((orderErr).^2+(Bstd(i)*orderChange/Bmean(i)).^2).^(1/2)
        [orderChangeAvg,orderErrAvg] = weightedAvg(orderChange,orderErr)
        [ratioSplitAvg,ratioSplitErrAvg] = weightedAvg(ratioSplit,ratioSplitErr)
        [bohravg,bohrErravg] = weightedAvg(bohr,bohrErr)
        output = [output,{analyses{j} i Bmean(i) Bstd(i) orderChangeAvg orderErrAvg ratioSplitAvg ratioSplitErrAvg bohravg bohrErravg}']
    end
    % change my answers to cm^-1/gauss
    a=1;
    % error plus measurement/other sources of error like doppler spreading
    if j == 1
        ZeemanTotals = [ ratioSplitAvg, ratioSplitErrAvg, bohravg, bohrErravg ]
    end
    if ~isempty(strfind('Good',analyses{j})) && j~=1 && isempty(strfind('Yellow',analyses{j}))
        ZeemanTotals = [ ZeemanTotals;ratioSplitAvg, ratioSplitErrAvg, bohravg, bohrErravg]
    end
end
splitRatioWeights = ZeemanTotals(:,2).^(-2)
bohrweights = ZeemanTotals(:,4).^(-2)
Esplit = ZeemanTotals(:,1)
bohr = ZeemanTotals(:,3)
magnetonFinal = sum(bohrweights.*bohr)/sum(bohrweights)
magnetonFinalErr = 1/sqrt(sum(bohrweights))
EsplitFinal = sum(splitRatioWeights.*Esplit)/sum(splitRatioWeights)
EsplitFinalErr = 1/sqrt(sum(splitRatioWeights))
output = [output,{'Final Weighted Analysis' 'Joshua' 'Energy Split' EsplitFinal 'ESplitError' EsplitFinalErr 'Bohr Magneton' magnetonFinal 'Error' magnetonFinalErr}']
tableout = cell2table({output})
%FIX Below, finish Balmer, output graphs, add doppler, etc start write up
outputData = writetable(tableout.Var1{1,1},'/Users/JoshuaLevy/Desktop/ClassesSpring2017/111B/Labs/Atomic Physics/Data/ATMOutput.xlsx')
function [y,dy] = weightedAvg(x,x_err)
weights = x_err.^(-2)
y = sum(weights.*x)/sum(weights)
dy = 1/sqrt(sum(weights))
end