function [ Foot ] = relativePosition(Foot,B,segmentName)
%relativePosition

stanceNumber=1;
        
    for i=1:2:length(Foot.times)-1 %create interval matrix with touchdown and liftoff times
        Foot.int(stanceNumber,:)=(Foot.times(i:i+1))'; 
        stanceNumber=stanceNumber+1; 
    end;
    
Foot.numStrides=stanceNumber-1; %records total number of foot stances per trial
    


    for strideNumber=1:Foot.numStrides; %assign frame to corresponding liftoff/touchdown time in new frame interval matrix
        

        
        
        %find corresponding frame in trial for touchdown on given stride
        frameNumber=find(B.time == Foot.int(strideNumber,1)); 
        if isempty(frameNumber)==1 %if touchdown occurs before first recording frame
            Foot.frames(strideNumber,1)=1;
        else
        Foot.frames(strideNumber,1)=frameNumber;
        end;
        
        
        %find corresponding frame in trial for liftoff on given stride
        frameNumber=find(B.time == Foot.int(strideNumber,2)); 
        if isempty(frameNumber)==1 %if liftoff occurs after last recording frame
            Foot.frames(strideNumber,2)=B.num_samples;
        else
        Foot.frames(strideNumber,2)=frameNumber;
        end;
        
        %create an empty matrix that is to be filled by the relative x-y
        %data for each stride
        relpos=zeros(Foot.frames(strideNumber,2)-Foot.frames(strideNumber,1),2);
        relFR=zeros(Foot.frames(strideNumber,2)-Foot.frames(strideNumber,1),2);
        
        
            %construct x and y basis vectors, and find relative position        
        for frame=Foot.frames(strideNumber,1):Foot.frames(strideNumber,2)

        %Front Lizard segment (body to shoulders)
        Yf=B.MarkerPos{7}(frame,:)-B.MarkerPos{6}(frame,:);
        yf(frame,:)=Yf/sqrt(Yf*Yf'); %normalization
        xf(frame,:)=(T*yf(frame,:)')'; %rotation of y unit vector 90 degrees CW
        
        %Rear Lizard segment (hip to body)
        Yr=B.MarkerPos{6}(m,:)-B(n).MarkerPos{5}(frame,:);
        yr(frame,:)=Yr/sqrt(Yr*Yr');
        xr(frame,:)=(T*yr(frame,:)')';
        
            if (strcmp(segmentName,'front'))
                relFR(frame-Foot.frames(strideNumber,1)+1,:)=Foot.foot_pos(2*strideNumber-1,:)-B.R{6}(frame,:);
                relpos(frame-Foot.frames(strideNumber,1)+1,:)=[relFR(frame-Foot.frames(strideNumber,1)+1,:)*xf(frame,:)',relFR(frame-Foot.frames(strideNumber,1)+1,:)*yf(frame,:)'];
            end;
            
            if (strcmp(segmentName,'rear'))
                relFR(frame-Foot.frames(strideNumber,1)+1,:)=Foot.foot_pos(2*strideNumber-1,:)-B.R{5}(frame,:);
                relpos(frame-Foot.frames(strideNumber,1)+1,:)=[relFR(frame-Foot.frames(strideNumber,1)+1,:)*xr(frame,:)',relFR(frame-Foot.frames(strideNumber,1)+1,:)*yr(frame,:)'];
            end;

        end;
        
                    Foot.relFR{strideNumber}=relFR;
                    Foot.relpos{strideNumber}=relpos;
                    
        
    end;
end;

