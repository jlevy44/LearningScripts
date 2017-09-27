function [ A ] = pos( A,B, XYR, segmentName ) %segment is either front or back
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
s=size(B);
for n=1:s(2)
    z=1;
    for m=1:2:length(A(n).foot_pos)-1
        A(n).stepUse(z)=A(n).foot_pos(m);
        z=z+1;
    end;
    
    for l=1:A(n).numStrides
        FRout=zeros(A(n).frames(l,2)-A(n).frames(l,1),2);
        relFR=zeros(A(n).frames(l,2)-A(n).frames(l,1),2);
        
        
        for w=A(n).frames(l,1):A(n).frames(l,2)
            b=w-A(n).frames(l,1)+1;     % Index into lth stride window
            
            if (strcmp(segmentName,'front'))
                relFR(b,:)=A(n).foot_pos(2*l-1,:)-XYR.Rfront{n}(w,:);
                FRout(b,:)=[relFR(b,:)*XYR.xf{n}(w,:)',relFR(b,:)*XYR.yf{n}(w,:)'];
            end;
            
            if (strcmp(segmentName,'rear'))
                relFR(b,:)=A(n).foot_pos(2*l-1,:)-XYR.Rrear{n}(w,:);
                FRout(b,:)=[relFR(b,:)*XYR.xr{n}(w,:)',relFR(b,:)*XYR.yr{n}(w,:)'];
            end;
        end;
        A(n).relFR{l}=relFR;
        A(n).relpos{l}=FRout;
        
    end;
end;
end

