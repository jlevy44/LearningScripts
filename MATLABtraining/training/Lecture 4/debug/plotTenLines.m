function plotTenLines
tic
profile on
%make x vector
x=-1:.01:1
%make a figure and plot 10 random lines, labeling each one
for n=1:10
    plot(x,polyval(rand(3,1),x),'color',rand(1,3));
    hold on;
    legendNames{n,:}=['Line ' num2str(n)] %the brackets turn it into a string array
    %used debugging above by setting a breakpoint in line 8, checked other
    %functions using step in
end
a=toc
%label the graph
xlabel('X');
ylabel('Y');
title('Ten Line Plot');
legend(legendNames);
pause;
close 1;
b=toc
%tic resets timer, toc returns current value, may have multiple tocs
profile viewer
%measures performance and how much time spent in a function
end

