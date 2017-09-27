function [xc]=XC(r)
x(1) = 0.0000001 
for i = 1:1999
    x(i + 1) = r* x(i)* (1 - x(i)); 
end;
if x(end)>x(end-1)
    xc=x(end)
else
    xc=x(end-1)
end;
end