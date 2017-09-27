function [ trialID ] = WhichTrial( ClickInput,relfootdat,k, stanceNumber )
%WhichTrial Click where bad trial is and finds which trial and footstance
%it is so you can find and correct it
%   Detailed explanation goes here

distance = @(P,Q) sqrt(dot(P-Q,P-Q));

field={'FO','FI','HO','HI'};

% go through each trial and locate trial that is closest to clicked point
for i=1:size(relfootdat')
    if ~isequaln(relfootdat(i).(field{k}){1,stanceNumber},NaN)
        for j=1:size(relfootdat(i).(field{k}){1,stanceNumber})
            distancesInTrial(j)=distance(ClickInput,...
                relfootdat(i).(field{k}){1,stanceNumber}(j,:));
        end;
        minDist(i)=min(distancesInTrial);
    else
        minDist(i)=NaN;
    end;
end;

% index of trial of minimum distance, used to find ID of trial
[~,minIndex]=min(minDist);
clc;

disp([relfootdat(minIndex).ID field{k} num2str(stanceNumber)]); 
% pause;

trialID={relfootdat(minIndex).ID{1,1},relfootdat(minIndex).ID{1,2},...
    relfootdat(minIndex).ID{1,3},field{k},stanceNumber};

end

