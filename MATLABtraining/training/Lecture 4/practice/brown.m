x=zeros(10000,1);
for n=2:10000; %x(1)=0, this is @t=0
    if rand<.5
        x(n)=x(n-1)-1;
    else
        x(n)=x(n-1)+1;
    end
end
figure;
hist(x,50); %second number is amount of bins
