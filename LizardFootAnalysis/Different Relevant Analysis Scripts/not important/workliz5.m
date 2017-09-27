for i=1:116
    clf;
    hold on;
    %i= input('Trial number: ') %this plots the center of mass of a front or rear
    %section of a particular trial for the front outer foot, for analysis on
    %its motion
    plot(abs(COM(i).FO{1,1}(:,1)),COM(i).FO{1,1}(:,2));
    plot(abs(COM(i).FO{1,1}(1,1)),COM(i).FO{1,1}(1,2),'o');
    axis image;
    
    pause;
    
    x=relfootdat(i).FO{1,1}(:,1);
    y=relfootdat(i).FO{1,1}(:,2)
    t=1:1:size(COM(i).FO{1,1}(:,1));
    dist=(x.^2+y.^2).^(1/2);
    
    clf;
    hold on;
    
    subplot(3,1,1);
    plot(t,abs(x));
    
    subplot(3,1,2);
    plot(t,y);
    
    
    
    
    subplot(3,1,3);
    plot(t, dist);
    pause;
%     if (min(dist) <= min())
%     [minvalue,hookmin]=min(x)
    %[minvalue,hookmin]=min(dist)
    
    line=polyfit(x,y,1)
    
    %actually plot distance sqrt(x^2 + y^2) or use min x
    
    %///////////////////////////////////////
    xb=relfootdat(i).FO{1,1}(:,1);
yb=relfootdat(i).FO{1,1}(:,2);

line=polyfit(xb,yb,1)

xb=1:1:size(relfootdat(i).FO{1,1}(:,1));
yb=line(1).*xb+line(2);
plot(xb,yb)

deltaP=[xb(2)-xb(1), yb(2)-yb(1)];
yc=deltaP/(dot(deltaP,deltaP)^(1/2))
xc=([0 1; -1 0]*yc')'

rel=[relfootdat(i).FO{1,1}(:,1), relfootdat(i).FO{1,1}(:,2)]

for j=1:size(relfootdat(i).FO{1,1}(:,1))
linedist(j)=dot(yc,rel(j,:));
end;

disp(linedist');

[minVal,minIndex]=min(linedist)

    %///////////////////////////////////////

    
    clf;
    
    hold on;
    plot(abs(x),y);
    plot(abs(x(1)),y(1),'o',abs(x(minIndex)),y(minIndex),'*');
    pause;
    clear x y t dist
end;