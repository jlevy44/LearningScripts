function [xS]=fixedPoint(r)
    if r<=1 && r>=0
        xS=0;
    else
        xS=(r-1)/r
    end;
end



