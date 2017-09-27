load ('LizardBuild.mat');


for n=1:7
plot(B(1).MarkerPos{n}(:,1),B(1).MarkerPos{n}(:,2))
hold on
%pause
end

hold off;
close all;

P1=B(1).MarkerPos{1}
P2=B(1).MarkerPos{2}
T=[0,1;-1,0]

for n=1:B(1).num_samples
    A(n,:)=P1(n,:)-P2(n,:)
    Y=A(n,:)
    yf(n,:)=Y/sqrt(Y*Y')
    
    xf=(T*yf')'
    Q1=B(1).feet(1).foot_pos(1,:);
    %change above
    F1test(n,:)=-(P1(n,:)+P2(n,:))/2+Q1;
    
    Fofficial(n,:)=[F1test(n,:)*xf(n,:)',F1test(n,:)*yf(n,:)'];

end
close all;
Fofficial
plot(Fofficial(120:300,1),Fofficial(120:300,2));
pause;
    plot(P1(:,1),P1(:,2),P2(:,1),P2(:,2))