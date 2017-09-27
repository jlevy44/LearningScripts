function [ Foot ] = relativePosition(B,i,segmentName)
%relativePosition


T=[0,1;-1,0]; %rotation matrix used to construct new x-y basis

Foot=B.feet(i); %assigns initial footdata to particular foot

stanceNumber=1;


for i=1:2:length(Foot.times)-1 %create interval matrix with touchdown and liftoff times
    Foot.intervalTime(stanceNumber,:)=(Foot.times(i:i+1))';
    stanceNumber=stanceNumber+1;
end;

Foot.numStrides=stanceNumber-1; %records total number of foot stances per trial



for strideNumber=1:Foot.numStrides; %assign frame to corresponding liftoff/touchdown time in new frame interval matrix
    
    
    %     Need to fix section: Foot.intervalFrame(strideNumber,1 or 2)=frameNumber+1;
    %find corresponding frame in trial for touchdown on given stride
    frameNumber=find(B.time == Foot.intervalTime(strideNumber,1));
    if isempty(frameNumber)==1 %if touchdown occurs before first recording frame
        Foot.intervalFrame(strideNumber,1)=1;
    else
        Foot.intervalFrame(strideNumber,1)=frameNumber;
    end;
    
    
    %find corresponding frame in trial for liftoff on given stride
    frameNumber=find(B.time == Foot.intervalTime(strideNumber,2));
    if isempty(frameNumber)==1 %if liftoff occurs after last recording frame
        Foot.intervalFrame(strideNumber,2)=B.num_samples;
    else
        Foot.intervalFrame(strideNumber,2)=frameNumber;
    end;
    
    %create an empty matrix that is to be filled by the relative x-y
    %data for each stride, the size of the matrix is determined by the
    %number of frames in each stance interval
    
    %relFR will be the vector of the foot relative to the COM with
    %respect to cartesian standard basis vectors
    relFR=zeros(Foot.intervalFrame(strideNumber,2)-Foot.intervalFrame(strideNumber,1),2);
    
    %relpos will be vector of foot relative to COM with respect to the
    %newly constructed xy basis vectors constructed below
    relpos=zeros(Foot.intervalFrame(strideNumber,2)-Foot.intervalFrame(strideNumber,1),2);
    
    %center of mass of particular front/rear body segment
    COM=zeros(Foot.intervalFrame(strideNumber,2)-Foot.intervalFrame(strideNumber,1),2);
    
    
    %construct x and y basis vectors with respect to front and rear body segments, and find relative position in both absolute coordinates and new basis coordinates
    for frame=Foot.intervalFrame(strideNumber,1):Foot.intervalFrame(strideNumber,2)
        
        %Experiment right here, there is an error because B.foot_pos(1,:)
        %produces an illogical result (-.01,.01), so footpos1 will be set
        %to footpos2 because the two are roughly equal. this is until
        %footpos1 can be recovered
        %note error has been fixed
        %Foot.foot_pos(1,:)=Foot.foot_pos(2,:);
        
        
        %Front Lizard segment (body to shoulders)
        Yf=B.MarkerPos{7}(frame,:)-B.MarkerPos{6}(frame,:);
        yf(frame,:)=Yf/sqrt(Yf*Yf'); %normalization
        xf(frame,:)=(T*yf(frame,:)')'; %rotation of y unit vector 90 degrees CW
        
        %Rear Lizard segment (hip to body)
        Yr=B.MarkerPos{6}(frame,:)-B.MarkerPos{5}(frame,:);
        yr(frame,:)=Yr/sqrt(Yr*Yr');
        xr(frame,:)=(T*yr(frame,:)')';
        
        %Create projections onto each basis vector will find the relative xy
        %data for each frame, relFR and relpos are reindexed
        
        %for cases of FO and FI
        if (strcmp(segmentName,'front'))
            COM(frame-Foot.intervalFrame(strideNumber,1)+1,:)=B.R{6}(frame,:); %center of mass in absolute cartesian coordinates used for further analysis
            relFR(frame-Foot.intervalFrame(strideNumber,1)+1,:)=Foot.foot_pos(2*strideNumber-1,:)-B.R{6}(frame,:);
            relpos(frame-Foot.intervalFrame(strideNumber,1)+1,:)=[relFR(frame-Foot.intervalFrame(strideNumber,1)+1,:)*xf(frame,:)',relFR(frame-Foot.intervalFrame(strideNumber,1)+1,:)*yf(frame,:)'];
        end;
        
        %for cases of RO and RI
        if (strcmp(segmentName,'rear'))
            COM(frame-Foot.intervalFrame(strideNumber,1)+1,:)=B.R{5}(frame,:); %center of mass in absolute cartesian coordinates used for further analysis
            relFR(frame-Foot.intervalFrame(strideNumber,1)+1,:)=Foot.foot_pos(2*strideNumber-1,:)-B.R{5}(frame,:);
            relpos(frame-Foot.intervalFrame(strideNumber,1)+1,:)=[relFR(frame-Foot.intervalFrame(strideNumber,1)+1,:)*xr(frame,:)',relFR(frame-Foot.intervalFrame(strideNumber,1)+1,:)*yr(frame,:)'];
        end;
        
    end;
    
    %Record relative xy data per each stride for each foot
    Foot.relFR{strideNumber}=relFR;
    Foot.relpos{strideNumber}=relpos;
    Foot.COMsegment{strideNumber}=COM;
     
end;

%This stores the two positions of foot in its first stance, to be used for
%later data analysis on foot slip/vector fields
Foot.firstStancePositions=Foot.foot_pos(1:2,:)

end

