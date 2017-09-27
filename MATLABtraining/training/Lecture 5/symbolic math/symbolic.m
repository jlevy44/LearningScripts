%symbolic variables are a data type

a= sym('1/3');
b=sym('4/5');
a*b
mat=sym([1 2;3 4])
c=sym('c','positive')
%tags that narrow down c range, eg c>0 w/ this
%see help sym

syms x y real
%makes symbolic x & y real numbers

d=a*b

(a-c)^2
expand((a-c)^2) %expands the above into a quadratic
ans
factor(ans) %ans is previous answer
matInv=inv(mat) %computes inverse symbolically (w/fractions)
pretty(expand((a-c)^2)) %use this???

collect(3*x+4*y-1/3*x^2-x+3/2*y)
%combines like terms

%simplify
simplify(cos(x)^2+sin(x)^2)

%substitute variables with either numbers or
subs('c^2',c,5) %substitutes c with 5 for expression c^2
subs('c^3',c,x*(y^2))

mat=sym('[a b;c d]')
mat2=mat*[1 3;4 -2] %matrix product symbolically
mat3=mat.*[1 3;4 -2] %elementwise

d=det(mat)

i=inv(mat)
i(2,2)
clear all;

%exercise
syms x y a b r real %all of sym data type
z='r^2=(x-a)^2+(y-b)^2'
solve(z,x)
solve(z, y)
%solve function solves symbolic expressions for variables

Q=int(x*exp(x),a,b)
subs(Q,{a,b},{0,2}) %substitute for a and b, 0 and 2 respectively