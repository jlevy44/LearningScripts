function [ footStance ] = probFluxAndVectorFields( relFoot, footStance,footName,stanceNumber)
%  [ footStance ] = probFluxAndVectorFields( relFoot, footStance,footName,stanceNumber)
% probFluxAndVectorFields Creates a superimposed image of the probability flux data (where the foot
% tends to be) and the vector field data (where the foot tends to go) for
% each foot and stance
% footName and stanceNumber are used for the output/labels on graph
% relFoot contains the processed relative foot datapoints for given foot
% and stance
% footStance is a structure that contains all of the information/fields for a
% particular foot and stance


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

S=size(relFoot);

%grab mins and maxs for each trial
for i=1:S(1)
    xmins(i)=min(relFoot{i,1}(:,1));
    xmaxs(i)=max(relFoot{i,1}(:,1));
    ymins(i)=min(relFoot{i,1}(:,2));
    ymaxs(i)=max(relFoot{i,1}(:,2));
end;

%find the mins and maxes for all of the trials for foot and stance and set them equal to the
%nearest integer
FootStance.xmin=floor(min(xmins));
FootStance.xmax=ceil(max(xmaxs));
FootStance.ymin=floor(min(ymins));
FootStance.ymax=ceil(max(ymaxs));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%% PROBABILITY FLUX DISTRIBUTION %%%%%%%%%%%%%
%creating x-y points for probability graph
[footStance.X,footStance.Y]=meshgrid(footStance.xmin:0.25:footStance.xmax,...
    footStance.ymin:0.25:footStance.ymax);

s=size(footStance.X);


%create flux points corresponding to all x,y points
footStance.fluxIn=zeros(s(1),s(2));

%radius of circle that will grab flux values
radius=0.75*0.5*sqrt(2);

for i=1:size(relFoot)
    %pull xb and yb basis data for specific trial
    xb=relFoot{i,1}(:,1);
    yb=relFoot{i,1}(:,2);
    
    for n=1:s(1)
        for m=1:s(2)
            
            %distance away some of these trial xb yb points are away from the center of
            %the circles
            distance=((xb-footStance.X(n,m)).^2+(yb-footStance.Y(n,m)).^2).^(1/2);
            
            %will add flux values if the the trial lies within the particular circle
            if (any(distance<=radius)==1)
                
                footStance.fluxIn(n,m)=footStance.fluxIn(n,m)+1;
                
            end;
            
        end;
        
    end;
    
    clear xb yb;
end;

%create graphs of probability distribution data
hold on;
contourf(footStance.X,footStance.Y,footStance.fluxIn)
contour(footStance.X,footStance.Y,footStance.fluxIn)

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
[footStance.X2,footStance.Y2]=meshgrid(footStance.xmin:0.5:footStance.xmax,...
    footStance.ymin:0.5:footStance.ymax);

s2=size(footStance.X2);

%initializing array that stores average slopes for a given region for each trial
footStance.Mcell=cell(size(footStance.X2));
footStance.weight=cell(size(footStance.X2));
footStance.UpDown=cell(size(footStance.X2));
footStance.trialCounter=zeros(size(footStance.X2));


hold on;

for n=1:s2(1)
    for m=1:s2(2)
        size(relFoot);
        
        for i=1:size(relFoot) %for each trial in each square grab the weighted average slope
            [footStance.Mcell{n,m}(i,:),footStance.weight{n,m}(i),...
                footStance.UpDown{n,m}(i),footStance.trialCounter(n,m)]=...
                (avgSlopeSquare(footStance.X2(n,m),footStance.Y2(n,m),...
                relFoot{i,1},footStance.trialCounter(n,m)));
            
            weightedAvgM{n,m}(i,:)=footStance.weight{n,m}(i)*footStance.Mcell{n,m}(i,:);
        end;
        
        %if a particular cell is empty, set it equal to zero
        if isempty(footStance.Mcell{n,m})==1
            footStance.Mcell{n,m}=[0,0];
            footStance.weight{n,m}=1;
            footStance.UpDown{n,m}=0;
        end;
        
        
        if (footStance.trialCounter(n,m)<3) 
            %if only 2 or less trials pass through square, record no vector
            footStance.vectorSlope{n,m}=[0,0];
        else
            
            %this gives out the mean weighted (average slope) vector in each square
            footStance.vectorSlope{n,m}=sum(weightedAvgM{n,m});
            
            %normalize vectorSlope
            footStance.vectorSlope{n,m}=footStance.vectorSlope{n,m}/...
                sqrt(dot(footStance.vectorSlope{n,m},footStance.vectorSlope{n,m}));
        end;
        
        %xb and yb vector components
        footStance.dx(n,m)=footStance.vectorSlope{n,m}(1,1);
        footStance.dy(n,m)=footStance.vectorSlope{n,m}(1,2);
        
        % This will determine whether to flip vector direction, is not not used
        footStance.netUpDown(n,m)=sum(footStance.UpDown{n,m});
    end;
    
    
end;

footStance.netUpDown=footStance.netUpDown;

%here is a plot of the slope vectors using quiver, keep as white
quiver(footStance.X2,footStance.Y2,footStance.dx,footStance.dy,.5,'color','w');

%%%%%%%%%%%%% END VECTOR FIELD WITH QUIVER %%%%%%%%%%%%%

hold off;


%labelling and saving processed data vector fields and probability
%distributions as figure
title([footName ' Stance ' num2str(stanceNumber) ' Vector Field and Flux Probability Distribution'])
xlabel('Lateral (cm)')
ylabel('Fore-Aft (cm)')
savefig([footName ' ' num2str(stanceNumber) ' Vector Field And Probability Distribution'])

end

