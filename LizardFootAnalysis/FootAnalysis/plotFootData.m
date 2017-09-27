function plotFootData( Foot,footName,stanceNumber )
%plotFootData( Foot,footName,stanceNumber ) plots all of the raw relative
%foot data for a particular foot and stance
%   footName is name of foot (eg. FO, FI) and stanceNumber is number of
%   stance (1, 2, 3); Foot contains all of the relative foot data points
%   and trials for a given footstance
%   figure is saved to file at end
figure;
hold on;


s=size(Foot)

for i=1:s(1)
plot(Foot{i,1}(:,1),Foot{i,1}(:,2),Foot{i,1}(1,1),Foot{i,1}(1,2),'o')
end;

title([footName ' ' num2str(stanceNumber) ' Raw Data Graph (No slip trials)'])
xlabel('Lateral (cm)')
ylabel('Fore-Aft (cm)')
axis image;
axis square;

savefig([footName ' ' num2str(stanceNumber) ' Raw (' num2str(s(1)) ' trials included)'])

end

