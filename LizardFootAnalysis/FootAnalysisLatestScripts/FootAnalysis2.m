function [ InputStructure ] = FootAnalysis2( LizBuild,InputFile)
%FootAnalysis2 performs same function as foot analysis but is completely
%restructured... Uses InputStructure

% only ERROR REMAINING IS IN THE THRESHOLD, WHICH SHOULD CHANGE AS YOU
% MODIFY B... THUS IT IS BEST TO NOT ADD A LOT OF NEW TRIALS TO B, YOU WANT
% IT AT FULL SIZE, CHANGE THRESHOLD BACK DOWN TO 1 STD FOR FINAL ANALYSIS

load(LizBuild);
s=size(B);


%Test to see what trials in InputStructure are in B
% for i=1:45
% InputStructure(i).ID=B(i).ID;
% end;

% part of input structure
processStruct=repmat(struct('remove',{NaN},'truncate',...
    {NaN}),1,3);

% initialize a structure if it has not already been created...
if nargin == 2
    load(InputFile); %this contains the Input Structure
else
    InputStructure=struct('FO',{},'FI',{},...
        'HO',{},'HI',{},'ID',{});
end;

% save initial InputStructure size for later use
initialInputStructureSize=size(InputStructure);

if any(size(InputStructure) ~= size(B'))
    % Flag all trials in input structure that are not in B structure
    k=1;
    for j=1:s(2)
        check=0;
        for i=1:size(InputStructure)
            if (all(cellfun(@isequaln,InputStructure(i).ID, B(j).ID)))
                check=1;
                break;
            end;
        end;
        if (check==0)
            inputMissing(k,1)=j;
            k=k+1;
        end;
    end;
    disp(inputMissing);
    for i=1:size(inputMissing)
        disp(B(inputMissing(i,1)).ID)
    end;
end;




%builds relative foot data along with other relevant aspects
[relfootdat,distStance] = RelativeFootData(B);
relfootdat=orderfields(relfootdat);

% Let's make a vector that stores the B(i) trial index corresponding to each
% relFootdata trial index
%for i=1:s(2)



% deleting a trial just means putting NaN's over it now...
% let's get rid of slip trials
%slip trials will be NaNd from data analysis, saved an index of these
%trials in the processed data
index=cellfun(@(c) strcmpi(c,'fp:slip'), {B.Substrate}');
slipCutTrials=find(index);
for i=1:size(slipCutTrials) % for each of the slip indices, turn all trials and flip fields equal to NaN
    [relfootdat(slipCutTrials(i)).FO,relfootdat(slipCutTrials(i)).FI,...
        relfootdat(slipCutTrials(i)).HO,relfootdat(slipCutTrials(i)).HI]=...
        deal({NaN,NaN,NaN});
    [distStance(slipCutTrials(i)).FO,...
        distStance(slipCutTrials(i)).FI,...
        distStance(slipCutTrials(i)).HO,...
        distStance(slipCutTrials(i)).HI]=deal({NaN,NaN,NaN});
end;

%proper formatting such that all structs are mx1 dimensions
%         relfootdat=relfootdat';
%         StancePositions=StancePositions';
%         a=1;

% now cut trials (foot stances) that fail slip threshold limits and separate
% feet out for additional analysis 
% ERROR is here!!! do not add to B struct else threshold limits will change
% and fault data....


%slipThreshold; TAKE OUT OF ANALYSIS FOR NOW... important script


a=1;
%now clearing some variables to clean up the workspace
clear check failedThresholdTrials i index InputFile j k...
    slipCutTrials stanceNumber stancePositions StancePositions LizBuild

% assigning NaNs to trials that dont have three foot stances and
% flipping data that crosses the fore-aft axis incorrectly
%plotting raw foot data

trialIdentity={};

for stanceNumber=1:3
    [relfootdat,trialID]=raw2processedPlot(relfootdat,stanceNumber);
    trialIdentity=[trialIdentity;trialID];
end;

save('OutlierTrialsCheck.mat','trialIdentity');
    error('Fix these trials in trialIdentity run debug one more time');

close all;

%now to truncate/remove additional trials as well before the vector/probability
%field
%conditions for truncation or removal of trial:
%TRUNCATION: cut all hooks
%REMOVAL OF TRIAL: for now, this will be trials FO2 #40 (points in the
%wrong direction, foot actually should start in negative lateral direction) and HI3 #22
% (The trial extends way beyond the statistical bounds of all of the other trials for HI3).
% Trial FI3 #37  will also be removed due to a sharp spike in the data, likely
% resulting from a faulty datapoint
% Update with new bad numbers... Assign NaNs to bad trials (removed trials)
%changing the above results, instead will be adding modifications to the
%input structure array

fields={'FO','FI','HO','HI'};

if any(size(InputStructure) ~= size(B'))
    % first work on adding inputs to the trials that need truncations or removals
    for i=1:length(inputMissing)
        % add entry to inputstructure
        
        
        InputStructureNew=struct('FO',processStruct,'FI',processStruct,...
            'HO',processStruct,'HI',processStruct,'ID',{NaN});
        InputStructureNew.ID=B(inputMissing(i)).ID;
        %         for k=1:size(fields)
        %             InputStructureNew.(fields{k})=processStruct;
        %         end;
        
        
        
        % access particular relative foot data trial that has not been recorded
        % in yet
        for k=1:size(relfootdat')
            if all(cellfun(@isequaln,B(inputMissing(i)).ID,relfootdat(k).ID))
                % input trial and save trial inputs to input data structure
                [InputStructureNew ] = errorCutoff(relfootdat(k),InputStructureNew,k);
                break;
            end;
        end;
        
        
        
        
        % save the InputStructure after each trial, and prompt to quit, if quit
        % can save structure
        % adding to structure below
        if initialInputStructureSize(1) > 1
            InputStructure=[InputStructure;InputStructureNew];
        else
            InputStructure=InputStructureNew;
            initialInputStructureSize = 2;
        end;
        
        %save structure
        saveProgress;
        
        
    end;
end;
a=1;

% use inputs for truncation/removal
for i=1:size(relfootdat')
    % match up relfootdat trials with inputstructure files
    for j=1:size(InputStructure)
        if (all(cellfun(@isequaln,relfootdat(i).ID, InputStructure(j).ID)))
            
      
            % finish truncation/removal process
            relfootdat(i) = inputManip(relfootdat(i), InputStructure(j) );
            break;
        end;
    end;
end

%grab field dimensions and
%plot vector fields superimposed on top of foot flux probability distributions
%finish slip threshold removal process here... Thresholds added
probFluxAndVectorFields(relfootdat)

end

