function [ width ] = tailWidth(s,cal,n)
%TAILWIDTH Summary of this function goes here
%   Detailed explanation goes here

    pplot = @(a) plot(a(:,1),a(:,2),'o');
    ds = @(p) sqrt(sum(diff(p).^2,2))*cal;
    dx=s(n+1,1)-s(n-1,1);
    dy=s(n+1,2)-s(n-1,2);
    m=dy/dx;
    x=linspace(s(n,1)-70,s(n,1)+70);
    plot(x,-(1/m)*(x-s(n,1))+s(n,2));
    axis([s(n,1)-1300*cal s(n,1)+1300*cal s(n,2)-1300*cal s(n,2)+1300*cal])
    disp(['Now measuring width of tail section. Please click along the line. ' ... 
        'Click the top part of tail section, then bottom part.']);
    w=ginput(2);
    width=ds(w);
    pplot(w);
    
        
        
end

