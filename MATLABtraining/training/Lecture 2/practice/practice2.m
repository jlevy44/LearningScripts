plotSin(2,3); 
plotSin(2);

%plot(x,y,'color marker line-style')
x=linspace(0,10,50);
y=sin(x);
z=sin(x.*y);
plot (x,y,'r.')
figure;
plot3(x,y,z);
figure;
%color red in dots no lines
%see help plot
clear all;
figure
x=-pi:pi/100:pi;
y=cos(4*x).*sin(10*x).*exp(-abs(x));
plot(x,y,'k.')

semilogx(x,y,'k');
figure
semilogy(x,exp(x),'k.-');
figure
loglog(x,y);
close all;
%doc line_props;

%3D

time=0:0.001:4*pi
x=sin(time);
y=cos(time);
z=time;
plot3(x,y,z,'k','LineWidth',2);
zlabel('Time');
%how do you limit these graphs???
%xlim=3;
%ylim=3;
help xlim;
zlim=3;
axis square;
pause; %press enter here
axis ij;
pause;
axis xy;
pause;
axis equal;
pause;
axis tight;
disp('press enter to continue');
pause;
close all;
clear all;
plotSin(4,5);
clc;
subplot(2,3,1);
xlabel('columns');
figure;
subplot(2,3,4:6);
pause;
%close([2]); %fix
%can save figures, see pg 25 MIT lect2

plotSin(4,5);
plotSin(3);
%page 28 figure out how to advance plot