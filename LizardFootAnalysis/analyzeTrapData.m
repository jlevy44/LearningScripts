function  analyzeTrapData(  )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%what works so far


% load different B data structures representing morphometrics of lizards
% from different dates

%however, more trials have been added to the analysis, perhaps should
%produce these structures again, only 76 trials in analysis when there are
%116 trials total produced now
clear all;
[B]=load('B201412.mat');
[Bmod(1)]=load('B20150202.mat');
[Bmod(2)]=load('B20150327.mat');
[Bmod(3)]=load('B20150409.mat');
[Bmod(4)]=load('B20150416.mat');
[Bmod(5)]=load('B20150423.mat');
[Bmod(6)]=load('B20150504.mat');
%[Bmod(7)]=load('B20150504.mat'); %erase this!
%[Bmod(7)]=load('B20150601.2.mat');  %error is here! %both will not be
%used...
[Bmod(7)]=load('B20150609.mat');
[Bmod(8)]=load('B20150615.mat');
[Bmod(9)]=load('B20150709.mat');
[Bmod(10)]=load('B20150730.mat');
% [Bmod(2)]=load('B20150730test.mat');

x=1;
y=1;
z=1;
mEnd=numel(B.B);
%going through each of the trials, pull the name out, and assign trial
%number to a particular lizard, lizard 19, 20, 21
for m=1:mEnd;
    names(m)=B.B(m).ID(2);
    if strcmp(names(m),'Animal 19')
        lizard19(x,1)=m;
        x=x+1;
    end
    if strcmp(names(m),'Animal 20')
        lizard20(y,1)=m;
        y=y+1;
    end
    if strcmp(names(m),'Animal 21')
        lizard21(z,1)=m;
        z=z+1;
    end
    m=m+1;
end


%list of animal names in order
names=names';

%arrays of trial numbers that correspond to each lizards
lizard19;
lizard20;
lizard21;

%Bmod is a struct array that contains all of the B structs from different
%dates
[~,l]=size(Bmod);

%going through each of the ~10 B data structures, one for a particular date
%B.B is baseline structure, from December 2014
%Bmod(n).B is structure from specific date as specified by n
%comparison between date specified by n and baseline structure for angular
%momentum over trials

%all of these average errors for particular dates are averaged and standard
%deviation is found; used in later analysis
    function [avgError,dayError,totalMorphoAvg,totalMorphoStd]=trapDiff(lizardTrials)
        n=1;
        while(n<=l) %iteration over different morphometric dates
            for i=1:size(lizardTrials) %iteration over all trials for given lizard
                j=lizardTrials(i); %j is the specific trial being mentioned
                errDay(i)=trapz(B.B(j).time,B.B(j).H-Bmod(n).B(j).H)/trapz(B.B(j).time,B.B(j).H);
                %error found between date-specific and baseline using trapezoidal
                %integration for particular trial
            end
            %average error for that specific date morphometrics
            avgError(n,1)=mean(errDay);
            %all of the different errors for all trials using that particular
            %date's morphometrics
            dayError(n,2:size(lizardTrials)+1)=roundn(errDay',-3);
            n=n+1;
        end;
        %average and standard deviation
        totalMorphoAvg=mean(avgError);
        totalMorphoStd=std(avgError);
    end

%average morphometric error comparing date-specific morpho to baseline
%individual trial morpho error comparing date-specific morpho to baseline
[avgError19,dayError19,mean19,std19]=trapDiff(lizard19)
[avgError20,dayError20,mean20,std20]=trapDiff(lizard20)
[avgError21,dayError21,mean21,std21]=trapDiff(lizard21)

%array of dates appended to a list of the average error for that specific
%date morphomodel
dates=[20150202;20150327;20150409;20150416;20150423;20150504;20150609;20150615;20150709;20150730]; %20150601; erased
avgError19(:,2)=dates;
avgError20(:,2)=dates;
avgError21(:,2)=dates;

%average morpho error for the array described above
avgError19(:,1)=roundn(avgError19(:,1),-3);
avgError20(:,1)=roundn(avgError20(:,1),-3);
avgError21(:,1)=roundn(avgError21(:,1),-3);

[dayError19(:,1),dayError20(:,1),dayError21(:,1)]=deal(dates);

disp('The error for lizard 19 for each trial over specific morphomodel dates is..:');
num2str(dayError19)
disp('The error for lizard 20 for each trial over specific morphomodel dates is..:');
num2str(dayError20)
disp('The error for lizard 21 for each trial over specific morphomodel dates is..:');
num2str(dayError21)


disp('The average error for lizard 19 for various morphomodel dates is..:');
num2str(avgError19)
disp('The average error for lizard 20 for various morphomodel dates is..:');
num2str(avgError20)
disp('The average error for lizard 21 for various morphomodel dates is..:');
num2str(avgError21)


% %FIX THIS FUNCTION AND THINK MORE ABOUT IT!!! USE ABSOLUTE VALUE???
% %if particular date average error is one standard deviation above or below
% %mean, flag it and list date of error
%     function [dateERR]=dateError(lizardTrials,avgError,mean,std)
%         i=1;
% for (n=1:size(l))
% if (or(avgError(n,1)<(mean-std),avgError(n,1)>(mean+std)))
%     dateERR(i)=avgError(n,2);
%     i=i+1;
% end;
% end;
%     end
%
% dateERR19=dateError(lizard19,avgError19,mean19,std19)
% dateERR20=dateError(lizard20,avgError20,mean20,std20)
% dateERR21=dateError(lizard21,avgError21,mean21,std21)


%changes: plot data with big differences, redigitize 1 image that is bad
%and get another set values and run program again,might code up

end

