a=[3 7 5;1 9 10; 30 -1 2]
b=min(a) %returns min of each column [a(2,1) a(3,2) etc..]
m=min(b) %returns min of matrix a
m=min(min(a)) %returns min of matrix a
m=min(a(:))
a(:) %turns a into column vector, w/ [col1;col2;col3]
[m,n]=find(min(a)) %this is incorrect, as find looks for a condition in a
                   %and min(a) is not a condition
[m,n]=min(a)%look up why lines 7 and 9 are wrong, I know they are though

                   
a=magic(3)
a=magic(5)

clear all;
clc;
pause;

%system linear equations Ax=b, solve for x, \ is important, solves for
%least squares x!

A=[1 2 -3;-3 -1 1; 1 -1 1];
b=[5;-8;0];
x=A\b %solution to equation
%if det(A)=/=0, then x=inv(A)*b

r=rank(A)
    %^number linearly indep rows or columns dimColA
d=det(A)
E=inv(A)
x=E*b

%different decompositions, see help for svd(X) and qr(X)
%eigenvalue decomposition, AP=PD
[P,D]=eig(A)

%examples of syst of linear eq, p.7 lect 3
%Ax=b
A=[1 4; -3 1];
b=[34;2];
rank(A);
x=inv(A)*b
%if rankA^^^=2, then invertible so can use inverse

A=[2 -2 ;-1 1 ;3 4];
b=[4; 3; 2];
rank(A);
x1=A\b %least squares solution b/c A is not invertible and is rectangular
error=abs(A*x1-b)


