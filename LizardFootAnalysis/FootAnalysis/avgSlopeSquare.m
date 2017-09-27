function [ avgSlopeM,weight,netUpDown,trialCounter ] = avgSlopeSquare( X,Y,relFoot,trialCounter )
%avgSlopeSquare average slope vectors of a particular trial passing through a
%specified square on the xy grid, also records the weight of the trial as
%number of datapoints passing through square

%pull xb and yb basis data for specific trial/square
xb=relFoot(:,1);
yb=relFoot(:,2);



%temporary x and y data that is within given box/square of side length 0.5
tempXY(:,1)=xb(xb<=X+0.25 & xb>=X-0.25 & yb<=Y+0.25 & yb>=Y-0.25);
tempXY(:,2)=yb(xb<=X+0.25 & xb>=X-0.25 & yb<=Y+0.25 & yb>=Y-0.25);

%number of datapoints in square
s=size(tempXY);


if (any(tempXY(:))==1 && s(1)>1) %if the XY data exists and is nonzero, take the path vectors all points
    
    %individual slope vectors ("differential" path vectors) found for
    %particular trial within square
    slope=diff(tempXY);
    
    %weight to be used to calculate the weighted average slope vector for the slope
    %field when compared with all trials that pass through square
    [weight,noval]=size(diff(tempXY));
    
    if isempty(slope)==1 %if there are no entries for slope (maybe 1 xy data point), slope vector = [0,0]
        slope=[0,0];
    end;
    
    %new avgSlope algorithm, add all of the vectors and then turn it into a
    %unit vector (this is the average of all vectors in the square)
    %There must be at least 2 data points in order to create a vector
    switch s(1)
        case 2
            avgSlopeM=slope/sqrt(dot(slope,slope)); % 2 data points average slope vector is vector between two points
            trialCounter=trialCounter+1; %if trial passes through square, add trial
            
        case 1
            avgSlopeM=[0,0];
        otherwise
            %add up differential slope vectors that are inside each square,
            %and turn into unit vector
            avgSlopeM=sum(slope);
            avgSlopeM=avgSlopeM/sqrt(dot(avgSlopeM,avgSlopeM));
            trialCounter=trialCounter+1; %if trial passes through square, add trial
    end;
    
    
    %will count total vertical displacement to aide in creation of vector field
    %and this will help figure out why some vectors are pointing upwards when
    %they're actually supposed to be pointing downwards
    %this is now not necessary
    netUpDown=sum(diff(tempXY(:,2)));
    
else
    avgSlopeM=[0,0]; %setting output slope vector to zero if empty array
    weight=0;
    netUpDown=0;
    
end;

end

