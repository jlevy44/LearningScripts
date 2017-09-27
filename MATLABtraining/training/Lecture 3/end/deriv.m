%p.23 lect 3
x=0:0.01:2*pi;
y=sin(x);
dydx=diff(y)./diff(x);
plot(x,y,x(1:end-1)+diff(x)/2,dydx);
%y(find(dydx==0))

mat=[1 3 5;4 8 6];
dm=diff(mat, 1,2) %=[3-1 5-3;8-4 6-8] first diff of mat along 2nd dimension
%see help for mat
%opposite of diff is cumulative sum, cumsum

[dx,dy]=gradient(mat)
%??? how does it work?

% integration
%simpson integration (uses quadratic approximations
q=quad('myfun',0,10)
q2=quad(@(x) sin(x).*x,0,pi)

%trapezoidal rule
x=0:0.01:pi;
z=trapz(x,sin(x))
z2=trapz(x,sqrt(exp(x))./x)
