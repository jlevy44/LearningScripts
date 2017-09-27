function [ A ] = time2Frames(A,B)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
s=size(B);
for n=1:s(2)
    for m=1:A(n).numStrides;
        l=find(B(n).time == A(n).int(m,1));
        if isempty(l)==1
            A(n).frames(m,1)=1;
        else
        A(n).frames(m,1)=l;
        end;
        l=find(B(n).time == A(n).int(m,2));
        if isempty(l)==1
            A(n).frames(m,2)=B(n).num_samples;
        else
        A(n).frames(m,2)=l;
        end;
        clear l;
    end;
end

end

