mat=reshape(1:10000,100,100)
arr=reshape(1:64,4,4,4)
%^^creates an array or matrix of numbers in ascending order
imagesc(mat);
%^^ values span colormap
colorbar
caxis([3000,7000]);
colormap(jet);
pause;
colormap(gray);
pause;
colormap(hot(256));
close all;
pause;
map=zeros(256,3);
map(:,2)=(0:255)/255;
colormap(map);
colormap(jet);
save colors.mat map;
%^^look up how above works
clear all;
close all;
clc;
pause;
load colors map;
x=-pi:0.1:pi;
y=-pi:0.1:pi;

[X,Y]=meshgrid(x,y); %makes a grid from the two vectors
surf(X,Y);
Z=sin(X).*cos(Y);
surf(X,Y,Z)
help surf;
surf(x,y,Z); %in this case, the colormap = range of Z
%figure out how to do this correctly >>>surf(x,y,Z,jet); 
%map is colormap as designed above
colormap(map);
pause;
shading flat;
pause; shading faceted; pause; shading interp; pause;
colormap(gray);
close all;
clc;
save grid X Y Z;
clear all;
pause;

load colors map; load grid X Y Z;
colormap(jet);
contour(X,Y,Z,'LineWidth',2)
hold on; %holds current color and linestyle for next graph, keeps current graph
mesh(X,Y,Z) %creates 3D mesh


plotSin(2,3);
pause;
hold off;

close all;
clc;
clear all;
pause;

theta=0:0.01:2*pi;
rho=cos(theta);

polar(theta,rho,'--');
pause;
close 1;

bar(theta,rho);
[X,Y]=meshgrid(1:10,1:10);
quiver(X,Y,rand(10),rand(10)); %velocity field
figure;
close ([1 2]);

stairs(1:10,rand(1,10));
pause;
fill([0 1 0.5], [0 0 1], 'r');
%doc specgraph;
%learn syntax of above functions


