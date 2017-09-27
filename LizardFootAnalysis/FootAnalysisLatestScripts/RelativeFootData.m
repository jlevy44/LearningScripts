function [ relfootdat, distStance ] = RelativeFootData( B )
%RelativeFootData Pulls out coordinates of footposition relative to front
%rear body segments
    %assigns a foottype from each trial to a foot type structure and runs
    %program that grabs footposition relative to front or rear body segment
    %and iterates it over all trials
    
%Note:HI HO and RO RI used interchangeably, can assume they mean the same thing

% load (lizbuild); %inputs lizard build structure B

s=size(B);

for n=1:s(2) %all trials
    
    %assigns a foottype from each trial to a foot type structure and runs
    %program that grabs footposition relative to front or rear body segment
    for i=1:4 
        
        if strcmp(B(n).feet(i).foottype,'HI') 
            HI(n)=relativePosition(B(n),i,'rear');
            if strcmp(B(n).feet(i).foot,'HR')==1 %flip trial to correct side
                for j=1:size(HI(n).relpos')
                    HI(n).relpos{j}(:,1)=-HI(n).relpos{j}(:,1);
                end;
            end;
            relfootdat(n).HI=HI(n).relpos;
            COMsegment(n).HI=HI(n).COMsegment;
            StancePositions(n).HI=HI(n).StancePositions;
            distStance(n).HI=HI(n).dist;
        end; 
        
        if strcmp(B(n).feet(i).foottype,'FO')
            FO(n)=relativePosition(B(n),i,'front');
            if strcmp(B(n).feet(i).foot,'FL')==1 %flip trial to correct side
                for j=1:size(FO(n).relpos')
                    FO(n).relpos{j}(:,1)=-FO(n).relpos{j}(:,1);
                end;
            end;
            relfootdat(n).FO=FO(n).relpos;
            COMsegment(n).FO=FO(n).COMsegment;
            distStance(n).FO=FO(n).dist;
            StancePositions(n).FO=FO(n).StancePositions;
        end;
        
        if strcmp(B(n).feet(i).foottype,'FI')
            FI(n)=relativePosition(B(n),i,'front');
            if strcmp(B(n).feet(i).foot,'FR')==1 %flip trial to correct side
                for j=1:size(FI(n).relpos')
                    FI(n).relpos{j}(:,1)=-FI(n).relpos{j}(:,1);
                end;
            end;
            relfootdat(n).FI=FI(n).relpos;
            COMsegment(n).FI=FI(n).COMsegment;
            distStance(n).FI=FI(n).dist;
            StancePositions(n).FI=FI(n).StancePositions;
        end;
        
        if strcmp(B(n).feet(i).foottype,'HO')
            HO(n)=relativePosition(B(n),i,'rear');
            if strcmp(B(n).feet(i).foot,'HL')==1 %flip trial to correct side
                for j=1:size(HO(n).relpos')
                    HO(n).relpos{j}(:,1)=-HO(n).relpos{j}(:,1);
                end;
            end;
            relfootdat(n).HO=HO(n).relpos;
            COMsegment(n).HO=HO(n).COMsegment;
            distStance(n).HO=HO(n).dist;
            StancePositions(n).HO=HO(n).StancePositions;
        end;
        
        %ID each trial
        relfootdat(n).ID=B(n).ID;
        distStance(n).ID=B(n).ID;
        
    end;
end;
end
