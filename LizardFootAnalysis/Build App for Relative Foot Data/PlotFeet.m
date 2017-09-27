i=input('Trial number: ')
close all;
hold on; 
Foot=relfootdat(i).FI;
s=size(Foot);

%this plots the foot positions for all trials for a particular foot
for n=1:s(2)
    Foot{1,n}
plot(Foot{1,n}(:,1),Foot{1,n}(:,2));  
plot(Foot{1,n}(1,1),Foot{1,n}(1,2),'o');  

end;
axis image;
hold off;
