function [Foot,failedThresholdTrials, distStanceSaved,threshold ] = StanceSlipDist( B, stancePositions, Foot, stanceNumber )
%stance/slip distance for a particular foot stance
%this will analyze how far the particular foot moved during its stance and
%will establish a threshold for what trials should be included as
%"non-slip" trials for further analysis for creation of vector field that
%will estimate lizard foot movement on a given stance between touchdown and
%liftoff


s=size(Foot)


for i=1:s(1) %finding distances travelled by each stance step for each foot
    
    s2=size(stancePositions{i,1});
    %if there exists a stance period, find its distance, if not, then
    %distance is empty
    if (stanceNumber<=s2(1)/2)
        deltaD(i,:)=stancePositions{i,1}(2*stanceNumber,:)-stancePositions{i,1}(2*stanceNumber-1,:);
        distStance(i)=(deltaD(i,:)*deltaD(i,:)')^(1/2);
    else
        distStance(i)=NaN;
        Foot{i,1}{1,stanceNumber}=NaN;
    end;
    
end;

%save processed data
distStanceSaved=distStance;

%throw out empty trials
distStance=distStance(~isnan(distStance));

%some stats on the distance data for the slip of the first stance
avgDistStance=mean(distStance);
stdDevDist=std(distStance);
medDist=median(distStance);
% histogram(distStance,100);
hold on;

%developed threshold for largest possible slip on stance allowed
threshold=avgDistStance+1*stdDevDist;
% plot([threshold threshold],[0 20],'LineWidth', 0.5);



%any trial that has first stance distance larger than the threshold will be
%negated from analysis, also being sure to exclude trials with nonexisting foot stance
%positions
index=logical(distStanceSaved >= threshold);


%recording trials that failed the threshold
failedThresholdTrials =find(index);

s3=size(failedThresholdTrials);

%gets rid of all trials that fail threshold by assigning NaN values to them
for i=1:s3(2)
    Foot{failedThresholdTrials(i),1}{1,stanceNumber}=NaN;
end


close all;
end

