function [ relFoot ] = raw2processedPlot( relFoot, stanceNumber )
%raw2processedPlot : any trial that has more data points to the left of the
%y axis, the x basis data will be flipped. This is almost like an absolute
%value function, except that some trials pass through the fore/aft axis and
%this needs to be taken into account; negates NaN entries
% particular FootStance that is not NaN will be plotted and saved to file

field={'FO','FI','HO','HI'};

s=size(relFoot);

for k=1:length(field) %iterate over all feet, considering one stance at time
    %assigning raw trial to processed trial, not including NaN entries
    % assign NaNs to footstance trials that don't have at least 3 stances
    
    figure;
    hold on;
    
    for i=1:s(2)
        if (numel(relFoot(i).(field{k}))<stanceNumber)
            relFoot(i).(field{k}){1,stanceNumber}=NaN;
        end;
        if (isempty(relFoot(i).(field{k}){1,stanceNumber}))
            relFoot(i).(field{k}){1,stanceNumber}=NaN;
        end;
        if (~isequaln(relFoot(i).(field{k}){1,stanceNumber},NaN))
            
            %flipping trials across the fore-aft axis that have most of their data
            %points in left of that axis
            if (all(relFoot(i).(field{k}){1,stanceNumber}(:,1)>=0)==0)
                tempFoot=[1,1];
            else
                tempFoot=(relFoot(i).(field{k}){1,stanceNumber}(:,1)>=0);
            end;
            
            S=size(tempFoot(:,1)); %number of points on the right
            S2=size(relFoot(i).(field{k}){1,stanceNumber}(:,1)); %total number of points
            
            %if start on left but more than 50% on right, no flip, flip all other
            %points that start on left
            %below code works, one exception
            if(relFoot(i).(field{k}){1,stanceNumber}(1,1)<0 && S(1)>=S2(2)/2) %error here, use all of this as guide to plot data and move towards truncation
                relFoot(i).(field{k}){1,stanceNumber}(:,1)=-relFoot(i).(field{k}){1,stanceNumber}(:,1); %flip the x-data over the y-axis
            end;
            
            %plots all of the raw relative
            %foot data for a particular foot and stance
            
            plot(relFoot(i).(field{k}){1,stanceNumber}(:,1),...
                relFoot(i).(field{k}){1,stanceNumber}(:,2),...
                relFoot(i).(field{k}){1,stanceNumber}(1,1),...
                relFoot(i).(field{k}){1,stanceNumber}(1,2),'o')
            
        end;
        
    end;
    
    % save figure to file and format each figure
    title([field{k} ' ' num2str(stanceNumber) ' Raw Data Graph (No slip trials)'])
    xlabel('Lateral (cm)')
    ylabel('Fore-Aft (cm)')
    axis image;
    axis square;
    savefig([field{k} ' ' num2str(stanceNumber) ' Raw '])
    
end;


end

