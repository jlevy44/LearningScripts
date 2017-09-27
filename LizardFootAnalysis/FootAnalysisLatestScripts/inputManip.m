function [ FeetTrial ] = inputManip( FeetTrial, InputStructureTrial )
%[ FeetTrial ] = inputManip( FeetTrial, InputStructureTrial ) Will truncate
%files and remove them as specified by the errorCutoff
%   Performing Truncation/Removal on Each Trial

% for each trial, go through a field and then all of the stancesNumbers in
% the field
fields={'FO','FI','HO','HI'};

for k=1:4 % go through each field/Foot
    
    for stanceNumber=1:3 % go through each stance for Foot for trial
        S=size(FeetTrial.(fields{k}){1,stanceNumber});
        k;
        stanceNumber;
        if k==2 && stanceNumber ==1
            a=1;
        end;
        %reassign this particular trial the truncated datapoints or remove
        %the trial altogether
        if (InputStructureTrial.(fields{k})(stanceNumber).remove==0)
            FeetTrial.(fields{k}){1,stanceNumber}=...
                FeetTrial.(fields{k}){1,stanceNumber}(InputStructureTrial.(fields{k})(stanceNumber).truncate(3):S(1),:);
            clf;
            plot (FeetTrial.(fields{k}){1,stanceNumber}(:,1),...
                FeetTrial.(fields{k}){1,stanceNumber}(:,2));
        else
            FeetTrial.(fields{k}){1,stanceNumber}=NaN;
        end;
        
    end;
end;

end

