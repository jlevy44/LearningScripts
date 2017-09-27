function  probFluxAndVectorFields( relfootdat)
%  probFluxAndVectorFields( relfootdat)
% probFluxAndVectorFields Creates a superimposed image of the probability flux data (where the foot
% tends to be) and the vector field data (where the foot tends to go) for
% each foot and stance
% footName and stanceNumber are used for the output/labels on graph
% relFoot contains the processed relative foot datapoints for given foot
% and stance
% footStance is a structure that contains all of the information/fields for a
% particular foot and stance

% will iterate over footStance Numbers and fields, as well as all trials
fields={'FO','FI','HO','HI'};

% if trial footStance fails assigned thresholds, remove from analysis
slipThresholds=[4,4,4,4]; %corresponds to FO,FI,HO,HI respectively

for k=1:4
    for stanceNumber=1:3
        
        %first grab dimensions (xmin/xmax,ymin/ymax) for each foot and stance and
        %use these dimensions in creation of bounds and xy mesh of probability distribution and vector
        %field
        
        %need to plot the probability flux distribution surface/contour
        %these will be operationalized more in the future, but for now are the
        %number of trials passing through a particular region
        
        %new figure
        figure;
        
        %%%%%%%%%%%%% GRAB FIELD DIMENSIONS %%%%%%%%%%%%%
        
        %grab the minimum and max xy values for all trials for foot and foot
        %stride, will change function later to reflect foot stride and foot type
        
        S=size(relfootdat);
        j=1;
        %grab mins and maxs for each trial
        for i=1:S(2) %%%%!@#@$#^&^*&(^&%^$#@
            if (isequaln(relfootdat(i).(fields{k}){1,stanceNumber},NaN)==0 ...
                && distStance(i).(fields{k}){stanceNumber} < slipThresholds(k))
                xmins(j)=min(relfootdat(i).(fields{k}){1,stanceNumber}(:,1));
                xmaxs(j)=max(relfootdat(i).(fields{k}){1,stanceNumber}(:,1));
                ymins(j)=min(relfootdat(i).(fields{k}){1,stanceNumber}(:,2));
                ymaxs(j)=max(relfootdat(i).(fields{k}){1,stanceNumber}(:,2));
                j=j+1;
            end;
        end;
        
        %find the mins and maxes for all of the trials for foot and stance and set them equal to the
        %nearest integer
        xmin=floor(min(xmins));
        xmax=ceil(max(xmaxs));
        ymin=floor(min(ymins));
        ymax=ceil(max(ymaxs));
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        %%%%%%%%%%%%% PROBABILITY FLUX DISTRIBUTION %%%%%%%%%%%%%
        %creating x-y points for probability graph
        [X,Y]=meshgrid(xmin:0.25:xmax,...
            ymin:0.25:ymax);
        
        s=size(X);
        
        
        %create flux points corresponding to all x,y points
        fluxIn=zeros(s(1),s(2));
        
        %radius of circle that will grab flux values
        radius=0.75*0.5*sqrt(2);
        
        for i=1:size(relfootdat')
            if (isequaln(relfootdat(i).(fields{k}){1,stanceNumber},NaN)==0 ...
                    && distStance(i).(fields{k}){stanceNumber} < slipThresholds(k))
            %pull xb and yb basis data for specific trial
            xb=relfootdat(i).(fields{k}){1,stanceNumber}(:,1);
            yb=relfootdat(i).(fields{k}){1,stanceNumber}(:,2);
            
            for n=1:s(1)
                for m=1:s(2)
                    
                    %distance away some of these trial xb yb points are away from the center of
                    %the circles
                    distance=((xb-X(n,m)).^2+(yb-Y(n,m)).^2).^(1/2);
                    
                    %will add flux values if the the trial lies within the particular circle
                    if (any(distance<=radius)==1)
                        
                        fluxIn(n,m)=fluxIn(n,m)+1;
                        
                    end;
                    
                end;
            end;
                
            end;
            
            clear xb yb;
        end;
        
        %create graphs of probability distribution data
        hold on;
        contourf(X,Y,fluxIn)
        contour(X,Y,fluxIn)
        
        colorbar;
        axis image;
        
        %%%%%%%%%%%%% END PROBABILITY FLUX DISTRIBUTION %%%%%%%%%%%%%
        
        %%%%%%%%%%%%% VECTOR FIELD WITH QUIVER %%%%%%%%%%%%%
        %field dimensions will
        %be used to decide sizes of vector field and probability distribution,
        %squares (to find the average slope vectors) and circles (to find the flux)
        %using output of field dimensions to construct XY meshes
        
        %creating a different mesh for the vector field to create more revealing
        %figures
        [X2,Y2]=meshgrid(xmin:0.5:xmax,...
            ymin:0.5:ymax);
        
        s2=size(X2);
        
        %initializing array that stores average slopes for a given region for each trial
        Mcell=cell(size(X2));
        weight=cell(size(X2));
        UpDown=cell(size(X2));
        trialCounter=zeros(size(X2));
        
        
        hold on;
        j=1;
        for n=1:s2(1)
            for m=1:s2(2)
                
                for i=1:size(relfootdat') %for each trial in each square grab the weighted average slope
                    if (isequaln(relfootdat(i).(fields{k}){1,stanceNumber},NaN)==0 ...
                            && distStance(i).(fields{k}){stanceNumber} < slipThresholds(k))
                        [Mcell{n,m}(j,:),weight{n,m}(j),...
                            UpDown{n,m}(j),trialCounter(n,m)]=...
                            (avgSlopeSquare(X2(n,m),Y2(n,m),...
                            relfootdat(i).(fields{k}){1,stanceNumber},trialCounter(n,m)));
                        
                        weightedAvgM{n,m}(j,:)=weight{n,m}(j)*Mcell{n,m}(j,:);
                        j=j+1;
                    end;
                end;
                
                %if a particular cell is empty, set it equal to zero
                if isempty(Mcell{n,m})==1
                    Mcell{n,m}=[0,0];
                    weight{n,m}=1;
                    UpDown{n,m}=0;
                end;
                
                
                if (trialCounter(n,m)<3)
                    %if only 2 or less trials pass through square, record no vector
                    vectorSlope{n,m}=[0,0];
                else
                    
                    %this gives out the mean weighted (average slope) vector in each square
                    vectorSlope{n,m}=sum(weightedAvgM{n,m});
                    
                    %normalize vectorSlope
                    vectorSlope{n,m}=vectorSlope{n,m}/...
                        sqrt(dot(vectorSlope{n,m},vectorSlope{n,m}));
                end;
                
                %xb and yb vector components
                dx(n,m)=vectorSlope{n,m}(1,1);
                dy(n,m)=vectorSlope{n,m}(1,2);
                
                % This will determine whether to flip vector direction, is not not used
                netUpDown(n,m)=sum(UpDown{n,m});
            end;
            
            
        end;
        
        
        %here is a plot of the slope vectors using quiver, keep as white
        quiver(X2,Y2,dx,dy,.5,'color','w');
        
        %%%%%%%%%%%%% END VECTOR FIELD WITH QUIVER %%%%%%%%%%%%%
        
        hold off;
        
        
        %labelling and saving processed data vector fields and probability
        %distributions as figure
        title([fields{k} ' Stance ' num2str(stanceNumber) ' Vector Field and Flux Probability Distribution'])
        xlabel('Lateral (cm)')
        ylabel('Fore-Aft (cm)')
        savefig([fields{k} ' ' num2str(stanceNumber) ' Vector Field And Probability Distribution'])
        
        
        %%%%%%%%%%%%% Additional Statistical Analysis %%%%%%%%%%%%%
        %%%%%%%%%%%%% OMIT FOR NOW
        %         footStanceName=[footName,' ',num2str(stanceNumber)];
        %         statFoot(relFoot,footStanceName);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        clearvars -except k stanceNumber fields relfootdat
    end;
end;

end

