load('relfootdat.mat')

z=1;
for i=1:116;
    
    %movement of foot relative to basis xb and yb
    xb=relfootdat(i).FO{1,1}(:,1);
    yb=relfootdat(i).FO{1,1}(:,2);
    
    %fitting line to data in order to find hook point
    line=polyfit(abs(xb),yb,1)
    
    %plotting a line of the data fit and comparing to relative foot
    %position
    x=1:1:size(relfootdat(i).FO{1,1}(:,1));
    y=line(1).*(x-abs(xb(1)))+yb(1);
    plot(x,y,abs(xb),yb)
    
    %constructing new basis C that lies on polyfit line, the new basis will
    %also be centered at the origin of xb and yb
    deltaP=[x(2)-x(1); y(2)-y(1)];
    yc=deltaP/(dot(deltaP,deltaP))^(1/2)
    xc=[0 1; -1 0]*yc
    
    %will use positive of xb axis for measurements, this is a relative
    %vector for foot position
    rel=[abs(xb) yb]
    
    s=size(relfootdat(i).FO{1,1}(:,1));
    
    %line distances will measure the yc component of each relative vector
    linedist=zeros(s(1),1)
    
    %measurements below!
    for j=1:size(relfootdat(i).FO{1,1}(:,1))
        linedist(j,1)=rel(j,:)*yc;
    end;
    
    %records indices for min absolute xb value for foot and minimum yc
    %component
    [minLineDist,minLineIndex]=min(linedist)
    [minXbDist,minXbIndex]=min(abs(xb))
    
    axis image;
    
    %plotting graph of relative foot position as well as first rel position
    %and the appropriate hook cutoff line index
    plot (abs(xb),yb,'-', abs(xb(1)), yb(1), 'o', abs(xb(minLineIndex)), yb(minLineIndex),'*');
    
    %prompt to cut off hook
    cutHook=input('Cut off hook?(y/n): ','s');
    
    %reassigns relfootdat to only include xb and yb values past the hook
    %cutoff points, this is with respect to the min x or min y value
    if (strcmp(cutHook,'y')==1)
        relfootdat(i).FO{1,1}=relfootdat(i).FO{1,1}(minLineIndex:s(1),:)
    else
        plot (abs(xb),yb,'-', abs(xb(1)), yb(1), 'o', abs(xb(minXbIndex)), yb(minXbIndex),'*');
        cutHook2=input('How about now?: ','s')
        if (strcmp(cutHook2,'y')==1)
                    relfootdat(i).FO{1,1}=relfootdat(i).FO{1,1}(minXbIndex:s(1),:)
        else %these trials will be analyzed further to determine if there is truly an error, 
            %or if nothing should be done to the trial because it doesnt have a hook
            trialerror(z)=i;
            z=z+1;
        end;

        
    end;
    

    plot (abs(relfootdat(i).FO{1,1}(:,1)),relfootdat(i).FO{1,1}(:,2));
    pause;
        
end;
