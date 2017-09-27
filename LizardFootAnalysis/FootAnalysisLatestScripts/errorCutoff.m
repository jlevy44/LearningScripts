function [InputStructureTrial ] = errorCutoff( FeetTrial,InputStructureTrial,relativeFootIndex)
%errorCutoff will flag trials with errors and decide whether to remove or
%cut frames from them
% [InputStructure ] = errorCutoff( FeetTrial,InputStructure,relativeFootIndex) inputs the relative
% footdata/xbyb datapoints for all) and saves stats and
% information about the footdata being manipulated in Foot;
% datapoints are truncated and removed in Foot and information about the
% truncation and removals are in InputStructure

% for each trial, go through a field and then all of the stancesNumbers in
% the field
fields={'FO','FI','HO','HI'};

hold off;

for k=1:4 % go through each field/Foot
    
    for stanceNumber=1:3 % go through each stance for Foot for trial
        
        
        % if trial is NaN, skip analysis
        if isequaln(FeetTrial.(fields{k}){1,stanceNumber},NaN);
            skipAnalysis=1; 
        else
            skipAnalysis=0;
        end;
        
        %when trial footstance doesn't have NaN, then run code instead of breaking
        %to main function
        if (skipAnalysis == 0)
            
            %Flag particular trial? If not, then assign NaN to all Input data
            
            s=size(FeetTrial);
            
            j=1;
            %trials that just do not look normal or correct will be further analyzed
            %and a decision will be made to throw out these trials or not in the
            %stanceslipdist/cutoff matlab file, these error trials will be cut down and
            %have some data truncated if possible
            plot(FeetTrial.(fields{k}){1,stanceNumber}(:,1),...
                FeetTrial.(fields{k}){1,stanceNumber}(:,2),...
                FeetTrial.(fields{k}){1,stanceNumber}(1,1),...
                FeetTrial.(fields{k}){1,stanceNumber}(1,2),'o')
            axis image;
            disp([fields{k} num2str(stanceNumber) ' Trial ' ...
                num2str(relativeFootIndex)]);
            error=input('Flag Trial? (y?): ','s');
            if (strcmpi(error,'y')==1)
                flagged=1;
            else
                flagged=0;
            end;
            
            
            %START RIGHT HERE useful: S(i).(footix)(k).flag

            if flagged==0 % if trial not flagged, skip truncation/removal
                InputStructureTrial.(fields{k})(stanceNumber).remove=0;
                InputStructureTrial.(fields{k})(stanceNumber).truncate=[NaN,NaN,1];
            else  % if trial is flagged, go through truncation and removal
                
                %this script goes into each flagged trial and allows rejection of trial
                %or truncation of data as you see fit for best analysis
                
                
                %this will go through each of the flagged trials
                hold on;
                S=size(FeetTrial.(fields{k}){1,stanceNumber});
                disp([fields{k} num2str(stanceNumber) ' Trial ' ...
                    num2str(relativeFootIndex)]);
                
                
                %remove the trial? if yes, skip cutoff trials algorithm for
                %truncating trials
                decideRemove=input('Remove Trial? (y?): ','s');
                if (strcmpi(decideRemove,'y')==1)
                    InputStructureTrial.(fields{k})(stanceNumber).remove=1;
                else
                    InputStructureTrial.(fields{k})(stanceNumber).remove=0;
                end;
                
                %if decide not to remove trial, then will try to cut/truncate
                %trial, truncation algorithm
                while (InputStructureTrial.(fields{k})(stanceNumber).remove==0)
                    
                    %these will be guesses, help with guesses by posting size
                    %of trial
                    disp(['This trial has ' num2str(S(1)) ' datapoints...']);
                    disp('What frame are you thinking of using as first frame?: ');
                    [frameGuess(1),frameGuess(2)]=ginput(1);
                    
                    
                    %             find the closest value/frame to the clicked point
                    distV(:,1)=bsxfun(@minus,FeetTrial.(fields{k}){1,stanceNumber}(:,1),frameGuess(1,1));
                    distV(:,2)=bsxfun(@minus,FeetTrial.(fields{k}){1,stanceNumber}(:,2),frameGuess(1,2));
                    dist=(distV(:,1).^2 + distV(:,2).^2).^(1/2);
                    [~,frameCut]=min(dist);
                    clear distV;
                    
                    %plot cutoff frame and see if user is satisfied with selection
                    plot (FeetTrial.(fields{k}){1,stanceNumber}(frameCut,1),...
                        FeetTrial.(fields{k}){1,stanceNumber}(frameCut,2),'*');
                    
                    satisfied=input('Cut from here?(y/n): ','s');
                    
                    %end loop if satisfied and move to next trial
                    if strcmpi(satisfied,'y')==1
                        InputStructureTrial.(fields{k})(stanceNumber).truncate(1,1:2)=frameGuess;
                        InputStructureTrial.(fields{k})(stanceNumber).truncate(1,3)=frameCut;
                        break
                    end;
                end;
                
                %         %reassign this particular trial the truncated datapoints or remove
                %         %the trial altogether
                %         if (remove==0)
                %             FeetTrial{footStance.flaggedTrials(i),1}=FeetTrial{footStance.flaggedTrials(i),1}(frameCut:S(1),:)
                %             numberCutoff=numberCutoff+1;
                %             clf;
                %             plot (FeetTrial{footStance.flaggedTrials(i),1}(:,1),FeetTrial{footStance.flaggedTrials(i),1}(:,2));
                %             pause;
                %         end;
                %         if (remove==1)
                %             FeetTrial{footStance.flaggedTrials(i),1}=NaN;
                %         end;
                
            end;
            
        end;
        
        if (skipAnalysis == 1)
            InputStructureTrial.(fields{k})(stanceNumber).remove=NaN;
            InputStructureTrial.(fields{k})(stanceNumber).truncate=NaN;
        end;
        hold off;
    end;
end;
close all;
a=1;
end

