function y = fitfunction( x,p0,p1,a1,b1,c1 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

y = p0 + x.*p1 + a1*exp(-((x-b1)./c1).^2)

end

