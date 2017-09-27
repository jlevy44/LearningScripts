function [xa,rOut]=XA(r)
x(1) = 0.01; 
for i = 1:999
  x(i+1) = r* x(i)* (1 - x(i)) ;
 x(i+1)=floor(x(i+1)*2^(16)) *2.^(-16);
 %x(i + 1) = r* xnew* (1 - xnew) ;
end;
xa=x(501:999);
rOut=zeros(size(xa));
rOut(rOut==0)=r;
% if x(end)>x(end-1)
%     [xa]=x(end)
% else
%     xa=x(end-1)
% end;
end


