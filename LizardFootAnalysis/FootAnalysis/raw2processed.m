function [ processedFoot ] = raw2processed( rawFoot, stanceNumber )
%raw2processed will assign raw foot structures with first 3 strides to a
%"processed" structure that will be used for further analysis, all empty
%trials/stances will be erased and the structures will have the stance
%numbers in the columns and trials for rows...

%also included: for any trial that has more data points to the left of the
%y axis, the x basis data will be flipped. This is almost like an absolute
%value function, except that some trials pass through the fore/aft axis and
%this needs to be taken into account


s=size(rawFoot);
j=1;
%assigning raw trial to processed trial, not including NaN entries
for i=1:s(1)
    if (isnan(rawFoot{i,1}{1,stanceNumber})==0)
        processedFoot{j,1}=rawFoot{i,1}{1,stanceNumber};

        
        %flipping trials across the fore-aft axis that have most of their data
        %points in left of that axis 
        if (all(processedFoot{j,1}(:,1)>=0)==0)
            tempFoot=[1,1];
        else
        tempFoot=processedFoot{j,1}(processedFoot{j,1}(:,1)>=0);
        end;
        
        S=size(tempFoot(:,1)); %number of points on the right
        S2=size(processedFoot{j,1}(:,1)); %half the total number of points

%if start on left but more than 50% on right, no flip, flip all other
%points that start on left
%below code works, one exception
 if(processedFoot{j,1}(1,1)<0 && S(1)>=S2(2)/2)
     processedFoot{j,1}(:,1)=-processedFoot{j,1}(:,1); %flip the x-data over the y-axis
 end;
    
        %add one to j for next added trial
        j=j+1;
    end;
    
end;
!

end

