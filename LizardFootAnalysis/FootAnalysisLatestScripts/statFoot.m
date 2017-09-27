function [ xbAvg,ybAvg,xbSD,ybSD ] = statFoot(foot,footStanceName)
%statFoot extracts mean starting positions and its x-y standard deviation
%in the correspinding basis. To be used for guassian curve construction
%etc. please use this after proper cutoffs have been made and vector field
%has been constructed


s=size(foot)

for i=1:s(1)
xbstart(i,1)=foot{i,1}(1,1);
ybstart(i,1)=foot{i,1}(1,2);
end;
xbstart
ybstart

xbAvg=mean(xbstart)
ybAvg=mean(ybstart)
xbSD=std(xbstart)
ybSD=std(ybstart)


%will plot length of each trajectory vs starting x or y position of foot
%find the length of each trajectory
for i=1:s(1)
    L(i)=sum((diff(foot{i,1}(:,1)).^2 + diff(foot{i,1}(:,2)).^2).^(1/2));
end;

subplot(2,1,1);
hold on;
%plot x starting point vs L, the trajectory length for the trial
for i=1:s(1)
    plot(foot{i,1}(1,1),L(i),'*');
end;
%graph labels
xlabel('Lateral Axis Starting Point (cm)');
ylabel('Total Trajectory Distance (cm)');
title([footStanceName,' Trajectory Distances vs. Starting xb']);

subplot(2,1,2);
hold on;
%now for starting y...
for i=1:s(1)
    plot(foot{i,1}(1,2),L(i),'*');
end;
%graph labels
xlabel('Fore-Aft Axis Starting Point (cm)');
ylabel('Total Trajectory Distance (cm)');
title([footStanceName,' Trajectory Distances vs. Starting yb']);

% figure;

% now a 3d plot of starting x vs starting y vs distance traveled
% for i=1:s(1)
%     hold on;
%     scatter3(foot{i,1}(1,1),foot{i,1}(1,2),L(i))
% end;


end

