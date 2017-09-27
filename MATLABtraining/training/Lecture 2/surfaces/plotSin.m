%functions
function plotSin(f1,f2)
    x=linspace(0,2*pi,f1*16+1);
    y=linspace(0,2*pi,f1*16+1);
    if nargin==1        

    %x=0:.005:2*pi;
    plot(x,sin(f1*x),'--rs','LineWidth',2,'MarkerFaceColor','k','MarkerSize',20);
    elseif nargin==2
        [X,Y]=meshgrid(x,y);
        disp('Two inputs were given');
        Z=sin(f1*X)+sin(f2*Y)
        subplot(2,1,1); %the last one stands for its position in the figure
        imagesc(x,y,Z); %displays an image of Z over x,y coordinates imagescr(x,y,Z(x,y))
        %Z(x,y) is represented as a color
        colorbar; %adds colorbar to figure
        colormap hot; %changes color code
        axis xy;
        
        subplot(2,1,2); %first two are dimensions of graph
        surf(X,Y,Z);
    end
end
