%functions
function plotSin(f1,f2)
    x=linspace(0,2*pi,f1*16+1);

    if nargin==1        

    %x=0:.005:2*pi;
    plot(x,sin(f1*x),'--rs','LineWidth',2,'MarkerFaceColor','k','MarkerSize',20);
    elseif nargin==2
        disp('Two inputs were given');
        subplot(2,1,1);
    end
end
