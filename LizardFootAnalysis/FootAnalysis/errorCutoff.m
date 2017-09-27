function [ Foot,footStance ] = errorCutoff( Foot,footStance)
%errorCutoff will flag trials with errors and decide whether to remove or
%cut frames from them
% [ Foot,footStance ] = errorCutoff( Foot,footStance) inputs the relative
% footdata/xbyb datapoints for a particular footstance (footStance) and saves stats and
% information about the footdata being manipulated in Foot;
% datapoints are truncated and removed in Foot and information about the
% truncation and removals are in footStance

%if there doesn't exist trials to be addressed, then trials have not been
%addressed
if (isempty(footStance.trialsAddressed))
    footStance.trialsAddressed='no';
end;

%for flagged trials, check later
flagged=0;

hold off;

%while trials have not been addressed, then run code instead of breaking
%to main function
while (strcmp(footStance.trialsAddressed,'no')==1)
    
    %first, will flag trials if not already flagged
    if (~isnan(footStance.flaggedTrials)==1) %PLEASE CHANGE THIS!!!
        flagged=1;
    end;
    
    %if trials have not been flagged, then run through flagging code
    while(flagged==0)
        s=size(Foot);
        
        j=1;
        %trials that just do not look normal or correct will be further analyzed
        %and a decision will be made to throw out these trials or not in the
        %stanceslipdist/cutoff matlab file, these error trials will be cut down and
        %have some data truncated if possible
        for i=1:s(1)
            plot(Foot{i,1}(:,1),Foot{i,1}(:,2),Foot{i,1}(1,1),Foot{i,1}(1,2),'o')
            axis image;
            disp(['Trial number ' num2str(i) ' of ' num2str(s(1))]);
            error=input('Flag Trial? (y?): ','s');
            if (strcmp(error,'y')==1)
                footStance.flaggedTrials(j,1)=i;
                j=j+1;
            end;
            
            %testing purpose, test out of this loop
            if (strcmp(error,'t')==1)
                testOut=NaN;
                break
            end;
            
        end;
        flagged=1; %this will break loop
    end;
    
    
    s=size(footStance.flaggedTrials) %next loop will require s(2)
    
    %this script goes into each flagged trial and allows rejection of trial 
    %or truncation of data as you see fit for best analysis
    numberRemoved=1;
    numberCutoff=1;
    
    %gets rid of error in if statement below this if statement
    if (s(1)==0)
        footStance.flaggedTrials(1,1)=NaN;
    end;
    
    %if no trials have been flagged, exit to main function
    if (isnan(footStance.flaggedTrials(1,1))==1)
        footStance.flaggedTrials=NaN; %has this already been used???
        footStance.removedTrials=NaN;
        footStance.cutoffTrials=NaN;
        footStance.trialsAddressed='yes';
        
        return;
    end;
    
    %this will go through each of the flagged trials
    for i=1:s(1)
        clf;
        hold on;
        S=size(Foot{footStance.flaggedTrials(i),1});
        disp(['Trial ' num2str(footStance.flaggedTrials(i))]); %test
        
        % plot graph
        plot (Foot{footStance.flaggedTrials(i),1}(:,1),Foot{footStance.flaggedTrials(i),1}(:,2));
        plot (Foot{footStance.flaggedTrials(i),1}(1,1),Foot{footStance.flaggedTrials(i),1}(1,2),'o');
        axis image;
        
        %z will be used in order to either go into cutoff algorithm or skip
        %it if remove trial
        z=1;
        
        %remove the trial? if yes, skip cutoff trials algorithm for
        %truncating trials
        decideRemove=input('Remove Trial? (y?): ','s');
        if (strcmpi(decideRemove,'y')==1)
            remove=1;
            footStance.removedTrials(numberRemoved,1)=footStance.flaggedTrials(i);
            numberRemoved=numberRemoved+1;
        else
            remove=0;
            z=0;
        end;
        
        %if decide not to remove trial, then will try to cut/truncate
        %trial, truncation algorithm
        while (z==0)
            
            %these will be guesses, help with guesses by posting size
            %of trial
            disp(['This trial has ' num2str(S(1)) ' datapoints...']);
            disp('What frame are you thinking of using as first frame?: ');
            [frameGuess(1),frameGuess(2)]=ginput(1);
            
            
            %             find the closest value/frame to the clicked point
            distV(:,1)=bsxfun(@minus,Foot{footStance.flaggedTrials(i),1}(:,1),frameGuess(1,1));
            distV(:,2)=bsxfun(@minus,Foot{footStance.flaggedTrials(i),1}(:,2),frameGuess(1,2));
            dist=(distV(:,1).^2 + distV(:,2).^2).^(1/2);
            [~,frameCut]=min(dist);
            clear distV;
            
            %plot cutoff frame and see if user is satisfied with selection
            plot (Foot{footStance.flaggedTrials(i),1}(frameCut,1),...
                Foot{footStance.flaggedTrials(i),1}(frameCut,2),'*');
            
            satisfied=input('Cut from here?(y/n): ','s')
            
            %end loop if satisfied and move to next trial
            if strcmpi(satisfied,'y')==1
                footStance.cutoffTrials(numberCutoff,1)=i;
                footStance.cutoffTrials(numberCutoff,2)=frameCut;
                
                z=1;
            end;
        end;
        
        %reassign this particular trial the truncated datapoints or remove
        %the trial altogether
        if (remove==0)
            Foot{footStance.flaggedTrials(i),1}=Foot{footStance.flaggedTrials(i),1}(frameCut:S(1),:)
            numberCutoff=numberCutoff+1;
            clf;
            plot (Foot{footStance.flaggedTrials(i),1}(:,1),Foot{footStance.flaggedTrials(i),1}(:,2));
            pause;
        end;
        if (remove==1)
            Foot{footStance.flaggedTrials(i),1}=NaN;
        end;
        
    end;
    
    
    %now to completely remove the NaN trials from the particular foot
    %stance
    index=~isnan(cellfun(@(c) c(1),Foot));
    Foot=Foot(index);
    
    %the trials have been addressed
    footStance.trialsAddressed='yes';
    
end;

end

