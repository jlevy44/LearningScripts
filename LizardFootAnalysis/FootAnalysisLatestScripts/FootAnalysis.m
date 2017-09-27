function [ FootAnalyze ] = FootAnalysis( LizBuild,FootAnalyzeMatFile)
%[ FootAnalyze ] = FootAnalysis( LizBuild,FootAnalyzeMatFile)
%   
%
%   FOOT ANALYSIS High Level function that analyzes stance periods of lizard
%   This application will take the lizard build data (LizBuild) and constructs relative
%   foot data for feet and stance periods (this data can also be loaded from FootAnalyzeMatFile). 
%   Then it will cut the slip
%   trials, then erase cells that fail a threshold (foot slips on ground
%   more than it should). Then the remaining raw data is plotted (12
%   plots). Then each foot/stance is analyzed for additional errors (trials
%   will be truncated/possibly thrown out), then probability flux density
%   surfaces and vector fields (processed) data will be plotted (12 plots).

%the data being analyzed is processed as if all foot/stance movements were
%all on the right side of the fore-aft axis of the lizard

%if relfootdat already exists and has gone through slip/threshold removal
%and is partially/fully done with additional cutoffs/removals, then skip to
%that point
rawDataAnalysis='not complete';

%if there are two input arguments (please place FootAnalyze.mat as the
%second input) and some progress has been made in the cutoff/removal
%algorithm, then skip to that algorithm using rawDataAnalysis
%will use this to initialize variables and structure fields as well
if (nargin==2)
    load(FootAnalyzeMatFile);
    if (strcmp(FootAnalyze.processed.FO(1).trialsAddressed,'yes')==1)
        rawDataAnalysis='complete';
    end;
else
    %initialize part of the structs for the FootAnalyze Struct Array
    FootAnalyze=struct('raw',struct,'processed',struct('FO',repmat(struct,1,3),...
        'FI',repmat(struct,1,3),'HO',repmat(struct,1,3),'HI',repmat(struct,1,3)));
end;

%initialize structs that will be used after the truncation/removal process
[FO,FI,HO,HI]=deal(repmat(struct('xmin',NaN,'xmax',NaN,'ymin',NaN,...
    'ymax',NaN,'X',NaN,'Y',NaN,'X2',NaN,'Y2',NaN,'fluxIn',NaN,'P',{NaN},...
    'dx',NaN,'dy',NaN,'dX',NaN,'dY',NaN,'netUpDown',NaN,'theta',NaN,...
    'Mcell',{NaN},'weight',{NaN},'UpDown',{NaN},'vectorSlope',{cell(1)},...
    'trialCounter',NaN),1,3));

[FootAnalyze.processed.FO,FootAnalyze.processed.FI,FootAnalyze.processed.HO,...
    FootAnalyze.processed.HI]=deal(catstruct(FootAnalyze.processed.FO,FO),...
    catstruct(FootAnalyze.processed.FI,FI),catstruct(FootAnalyze.processed.HO,HO),...
    catstruct(FootAnalyze.processed.HI,HI));
%license catstruct ^^^
% Copyright (c) 2015, Jos van der Geest
% All rights reserved.

clear FO FI HO HI %these will be used later, eliminate for now

switch rawDataAnalysis
    
    case 'not complete' %no FootAnalyze/truncation process has not started, perform initial raw analysis
        
        % load lizard build, now a B struct exists
        load(LizBuild);
        
        %builds relative foot data along with other relevant aspects
        [relfootdat,StancePositions] = RelativeFootData(B)
        
        %now to cut the slip trials
        %slip trials will be erased from data analysis, saved an index of these
        %trials in the processed data
        index=cellfun(@(c) strcmp(c,'FP:slip')+strcmp(c,'FP:Slip'), {B.Substrate}')
        FootAnalyze.processed.BslipCutTrials=find(index);
        relfootdat=relfootdat(~index);
        StancePositions=StancePositions(~index);
        
        %save B structure as raw data, also preserve original relfootdat after
        %cutting slip trials
        FootAnalyze.raw.B=B;
        FootAnalyze.raw.relfootdatOriginal=relfootdat;
        
        %assign stance positions for each foot to 2D cell
        stancePositions{:,1}={StancePositions.FO}';
        stancePositions{:,2}={StancePositions.FI}';
        stancePositions{:,3}={StancePositions.HO}';
        stancePositions{:,4}={StancePositions.HI}';
        
        % now cut trials (foot stances) that fail slip threshold limits and separate
        % feet out for additional analysis, this will empty cells elements that
        % fail threshold and will record these empty elements that either failed
        % threshold or do not exist
        
        %proper formatting
        FO={relfootdat.FO}';
        FI={relfootdat.FI}';
        HO={relfootdat.HO}';
        HI={relfootdat.HI}';
        
        % now cut trials (foot stances) that fail slip threshold limits and separate
        % feet out for additional analysis
        for stanceNumber=1:3
            [FO,FootAnalyze.processed.FO(stanceNumber).failedThresholdTrials,...
                FootAnalyze.processed.FO(stanceNumber).distStance,...
                FootAnalyze.processed.FO(stanceNumber).threshold] = ...
                StanceSlipDist( B, stancePositions{1,1}, FO, stanceNumber )
            
            [FI,FootAnalyze.processed.FI(stanceNumber).failedThresholdTrials,...
                FootAnalyze.processed.FI(stanceNumber).distStance,...
                FootAnalyze.processed.FI(stanceNumber).threshold] = ...
                StanceSlipDist( B, stancePositions{1,2}, FI, stanceNumber )
            
            [HO,FootAnalyze.processed.HO(stanceNumber).failedThresholdTrials,...
                FootAnalyze.processed.HO(stanceNumber).distStance,...
                FootAnalyze.processed.HO(stanceNumber).threshold] = ...
                StanceSlipDist( B, stancePositions{1,3}, HO, stanceNumber)
            
            [HI,FootAnalyze.processed.HI(stanceNumber).failedThresholdTrials,...
                FootAnalyze.processed.HI(stanceNumber).distStance,...
                FootAnalyze.processed.HI(stanceNumber).threshold] = ...
                StanceSlipDist( B, stancePositions{1,4}, HI, stanceNumber)
        end;
        
        %save relfootdat structure as raw data
        FootAnalyze.raw.relfootdat.FO=FO;
        FootAnalyze.raw.relfootdat.FI=FI;
        FootAnalyze.raw.relfootdat.HO=HO;
        FootAnalyze.raw.relfootdat.HI=HI;
        
        %create plottable raw data arrays that will be used for rest of data
        %analysis, the x data will be flipped such that all data is located
        %primarily to the right of the fore-aft-axis
        %this is not exactly like taking the absolute value, as some trials
        %pass through the y-axis, and this would cause errors if the
        %absolute values were taken
        for stanceNumber=1:3
            [ FootAnalyze.processed.relfootdat.FO{1,stanceNumber} ] = raw2processed( FO, stanceNumber )
            [ FootAnalyze.processed.relfootdat.FI{1,stanceNumber} ] = raw2processed( FI, stanceNumber )
            [ FootAnalyze.processed.relfootdat.HO{1,stanceNumber} ] = raw2processed( HO, stanceNumber )
            [ FootAnalyze.processed.relfootdat.HI{1,stanceNumber} ] = raw2processed( HI, stanceNumber )
            
            %plot raw data after threshold and slips removed, include labels in later
            %program
            plotFootData(FootAnalyze.processed.relfootdat.FO{1,stanceNumber},'FO',stanceNumber)
            plotFootData(FootAnalyze.processed.relfootdat.FI{1,stanceNumber},'FI',stanceNumber)
            plotFootData(FootAnalyze.processed.relfootdat.HO{1,stanceNumber},'HO',stanceNumber)
            plotFootData(FootAnalyze.processed.relfootdat.HI{1,stanceNumber},'HI',stanceNumber)
        end;
        
        close all;
        
        %initializing variables of interest
        for stanceNumber=1:3
            FootAnalyze.processed.FO(stanceNumber).cutoffTrials=cell(1);
            FootAnalyze.processed.FO(stanceNumber).removedTrials=cell(1);
            FootAnalyze.processed.FI(stanceNumber).cutoffTrials=cell(1);
            FootAnalyze.processed.FI(stanceNumber).removedTrials=cell(1);
            FootAnalyze.processed.HO(stanceNumber).cutoffTrials=cell(1);
            FootAnalyze.processed.HO(stanceNumber).removedTrials=cell(1);
            FootAnalyze.processed.HI(stanceNumber).cutoffTrials=cell(1);
            FootAnalyze.processed.HI(stanceNumber).removedTrials=cell(1);
            FootAnalyze.processed.FO(stanceNumber).trialsAddressed='no';
            FootAnalyze.processed.FO(stanceNumber).flaggedTrials=NaN;
            FootAnalyze.processed.FI(stanceNumber).trialsAddressed='no';
            FootAnalyze.processed.FI(stanceNumber).flaggedTrials=NaN;
            FootAnalyze.processed.HO(stanceNumber).trialsAddressed='no';
            FootAnalyze.processed.HO(stanceNumber).flaggedTrials=NaN;
            FootAnalyze.processed.HI(stanceNumber).trialsAddressed='no';
            FootAnalyze.processed.HI(stanceNumber).flaggedTrials=NaN;
        end;
        
end; %end of the switch that does the initial raw data analysis before the cutoff/truncation/removal

%now to truncate/remove additional trials as well before the vector/probability
%field
%conditions for truncation or removal of trial:
%TRUNCATION: cut all hooks
%REMOVAL OF TRIAL: for now, this will be trials FO2 #40 (points in the
%wrong direction, foot actually should start in negative lateral direction) and HI3 #22  
% (The trial extends way beyond the statistical bounds of all of the other trials for HI3). 
% Trial FI3 #37  will also be removed due to a sharp spike in the data, likely
% resulting from a faulty datapoint
for stanceNumber=1:3
    disp(['FO ' num2str(stanceNumber)])
    [ FootAnalyze.processed.relfootdat.FO{1,stanceNumber},FootAnalyze.processed.FO(stanceNumber) ] =...
        errorCutoff( FootAnalyze.processed.relfootdat.FO{1,stanceNumber},...
        FootAnalyze.processed.FO(stanceNumber));
    saveProgress
    
    disp(['FI ' num2str(stanceNumber)])
    [ FootAnalyze.processed.relfootdat.FI{1,stanceNumber},FootAnalyze.processed.FI(stanceNumber) ] =...
        errorCutoff( FootAnalyze.processed.relfootdat.FI{1,stanceNumber},...
        FootAnalyze.processed.FI(stanceNumber));
    saveProgress
    
    disp(['HO ' num2str(stanceNumber)])
    [ FootAnalyze.processed.relfootdat.HO{1,stanceNumber},FootAnalyze.processed.HO(stanceNumber) ] =...
        errorCutoff( FootAnalyze.processed.relfootdat.HO{1,stanceNumber},...
        FootAnalyze.processed.HO(stanceNumber));
    saveProgress
    
    disp(['HI ' num2str(stanceNumber)])
    [ FootAnalyze.processed.relfootdat.HI{1,stanceNumber},FootAnalyze.processed.HI(stanceNumber) ] =...
        errorCutoff( FootAnalyze.processed.relfootdat.HI{1,stanceNumber},...
        FootAnalyze.processed.HI(stanceNumber));
    saveProgress
end;
%save progress before heading into probability/vector field program
save('FootAnalyze.mat','FootAnalyze')


%grab field dimensions and
%plot vector fields superimposed on top of foot flux probability distributions
for stanceNumber=1:3
    [ FootAnalyze.processed.FO(stanceNumber) ] = probFluxAndVectorFields...
        ( FootAnalyze.processed.relfootdat.FO{1,stanceNumber}, ...
        FootAnalyze.processed.FO(stanceNumber),'Front Outer',stanceNumber);
    
    [ FootAnalyze.processed.FI(stanceNumber) ] = probFluxAndVectorFields...
        ( FootAnalyze.processed.relfootdat.FI{1,stanceNumber}, ...
        FootAnalyze.processed.FI(stanceNumber),'Front Inner',stanceNumber);
    
    [ FootAnalyze.processed.HO(stanceNumber) ] = probFluxAndVectorFields...
        ( FootAnalyze.processed.relfootdat.HO{1,stanceNumber}, ...
        FootAnalyze.processed.HO(stanceNumber),'Rear Outer',stanceNumber);
    
    [ FootAnalyze.processed.HI(stanceNumber) ] = probFluxAndVectorFields...
        ( FootAnalyze.processed.relfootdat.HI{1,stanceNumber}, ...
        FootAnalyze.processed.HI(stanceNumber),'Rear Inner',stanceNumber);
end;

%save final foot analysis
save('FootAnalyze.mat','FootAnalyze')

end