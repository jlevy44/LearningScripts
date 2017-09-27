footdat=load('relfootdat20151127(FO1vector).mat');
load('LizardBuild.mat')



s=size(footdat.relfootdatFO1);
close all;

%hold on;
z=1;
for i=1:s(2)

    hold on; %this plots the front outer foot stride one for each trial with respect to new basis vectors
    plot(abs(footdat.relfootdatFO1(i).FO{1,1}(:,1)),footdat.relfootdatFO1(i).FO{1,1}(:,2));
        plot(abs(footdat.relfootdatFO1(i).FO{1,1}(1,1)),footdat.relfootdatFO1(i).FO{1,1}(1,2),'o');
        disp (['Trial number ' num2str(i)]);
        disp(['File Name: ' B(i).filename]);
            axis image;
            

end;