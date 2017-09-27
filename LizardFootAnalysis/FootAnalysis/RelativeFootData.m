function [ relfootdat, COMsegment, StancePositions ] = RelativeFootData( B )
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
            relfootdat(n).HI=HI(n).relpos;
            COMsegment(n).HI=HI(n).COMsegment;
            StancePositions(n).HI=HI(n).StancePositions;
        end; 
        
        if strcmp(B(n).feet(i).foottype,'FO')
            FO(n)=relativePosition(B(n),i,'front');
            relfootdat(n).FO=FO(n).relpos;
            COMsegment(n).FO=FO(n).COMsegment;
            StancePositions(n).FO=FO(n).StancePositions;
        end;
        
        if strcmp(B(n).feet(i).foottype,'FI')
            FI(n)=relativePosition(B(n),i,'front');
            relfootdat(n).FI=FI(n).relpos;
            COMsegment(n).FI=FI(n).COMsegment;
            StancePositions(n).FI=FI(n).StancePositions;
        end;
        
        if strcmp(B(n).feet(i).foottype,'HO')
            HO(n)=relativePosition(B(n),i,'rear');
            relfootdat(n).HO=HO(n).relpos;
            COMsegment(n).HO=HO(n).COMsegment;
            StancePositions(n).HO=HO(n).StancePositions;
        end;
        
    end;
end;
end
