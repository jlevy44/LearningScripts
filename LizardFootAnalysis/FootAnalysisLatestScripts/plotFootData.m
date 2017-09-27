function plotFootData( relFoot,stanceNumber )
%plotFootData( Foot,footName,stanceNumber ) plots all of the raw relative
%foot data for a particular foot and stance
%   footName is name of foot (eg. FO, FI) and stanceNumber is number of
%   stance (1, 2, 3); Foot contains all of the relative foot data points
%   and trials for a given footstance
%   figure is saved to file at end

field={'FO','FI','HO','HI'};

s=size(relFoot);

for k=1:length(field)
    
figure;
hold on;
    
    for i=1:s(2)
        if (~isequaln(relFoot(i).(field{k}){1,stanceNumber},NaN))
            plot(relFoot(i).(field{k}){1,stanceNumber}(:,1),...
                relFoot(i).(field{k}){1,stanceNumber}(:,2),...
                relFoot(i).(field{k}){1,stanceNumber}(1,1),...
                relFoot(i).(field{k}){1,stanceNumber}(1,2),'o')
        end;
        
    end;
    
    title([field{k} ' ' num2str(stanceNumber) ' Raw Data Graph (No slip trials)'])
    xlabel('Lateral (cm)')
    ylabel('Fore-Aft (cm)')
    axis image;
    axis square;
    
    savefig([field{k} ' ' num2str(stanceNumber) ' Raw '])
    
end;

end

