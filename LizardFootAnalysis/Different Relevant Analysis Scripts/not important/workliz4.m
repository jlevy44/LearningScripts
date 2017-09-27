load('relfootdat.mat');




s=size(relfootdat);
close all;

%hold on;
z=1;
for i=1:s(2)
    clf;
    hold on; %this plots the front outer foot stride one for each trial with respect to new basis vectors
    plot(abs(relfootdat(i).FO{1,1}(:,1)),relfootdat(i).FO{1,1}(:,2));
        plot(abs(relfootdat(i).FO{1,1}(1,1)),relfootdat(i).FO{1,1}(1,2),'o');
        disp (['Trial number ' num2str(i)]);
        disp(['File Name: ' B(i).filename]);
            axis image;
            
            pause;

%         closerLook=input('Hook visible?: ')
%         
%         if closerLook ==1
%             relfootCloser(z).FO=relfootdat(i).FO;
%             trialNumber(z)=i;
%             z=z+1;
%         end;
        

        
end;
%axis image;

