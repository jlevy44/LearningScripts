x=rand(1,100);
inds = [find(x>0.4 & x<0.6)]'
%returns element number where this condition holds true

x=sin(linspace(0,10*pi,100));
count=length(find(x>0))
%this finds the length of the vector that displays the indices of the
%values that pass the condition, helps avoid loops
%vectorization= avoid loops, find is an example

a=rand(1,100);
b=zeros(1,100);
for n=1:100
    if n==1
        b(n)=a(n);
    else
        b(n)=a(n-1)+a(n);
    end
end
%remember matrix display output
disp('b= '); disp(b');

a=rand(1,100); %this is a row vector
b=([0 a(1:end-1)]+a)'
%b=a(1:end-1) %this is just a from index 1 to 99
%[0 a(1:end-1)] %this is a with a1=0 and all of the other indices switched
%up by 1, so a100 was replaced by a99
%the b listed above adds a to the previous vector described, which works!
%what just happened above??? check got it!



