y=rand(1,10)
L=plot(1:10,y) %grabs plotted line data
A=gca %grabs axes data
F=gcf %grabs figure data info
%the above will list properties that you can modify with set!

get(L);
yVals=get(L,'YData')
if(yVals==y);
    disp('yes');
else
    disp('no');
end

%use set to change properties
pause;
set(A,'FontName','Arial','XScale','log');
set(L,'LineWidth',1.5,'Marker','*','YData',rand(1,10));
%everything in figure customizable through handles^^^^^

im=imread('mlk.jpeg');
%imports image into matlab^^^, see help
%writes an image
imwrite(rand(300,300,3),'test1.jpg')
imwrite(ceil(rand(200)*256),jet(256),'test2.jpg');

close all;
for t=1:30
    imagesc(rand(200));
    colormap(gray);
    %pause(.5); %specifies how long frame is paused for
    drawnow(); %alternative to pause(), uses small increments
end

h=plot(1:10,1:10);
pause;
y=10:-1:1
set(h,'ydata',10:-1:1);

close all;
for n=1:30
    imagesc(rand(200));
    colormap(gray);
    M(n)=getframe; %returns a movie frame
end

movie(M,2,30) %loops movie twice at 30 fps
%figure out how to write movies to hard drive using videowriter!!! help!!!
%videowriter(M,'testMovie.avi','FPS',30,'compression','cinepak'); %save movie to hard drive

temp=ceil(rand(300,300,1,30)*256);
imwrite(temp,jet(256),'testGif.gif','delaytime',0.1,'loopcount',100);
%can also use getframe,frame2im,rgb2ind to convert plotted figure to
%indexed image, and then stack these images to 4D matrix and pass to
%imwrite, see doc for details

