%physics homework problem two
G=6.67408 * 10^(-11)
M=4.8685*10^(24)
r10=[-0.3993444894108475; -0.6109495939619072;  0.01445921917409501] %AU
v10 = [0.02347991246224333; -0.008692126661394253; -0.001212215913765956] %AU/day

r20 = [-0.3992765028637614; -0.6109754144482474;  0.01447582537021745] %AU 
v20 = [0.01688438600449534; -0.01102585180861504; -0.001124980483534076]

r10=r10*149597870.7*1000
r20=r20*149597870.7*1000;
v10=v10*149597870.7*1000/86400; %m/s
v20=v20*149597870.7*1000/86400;

r0=r10-r20;
v0=v10-v20;

lu=cross(r0,v0)

a=lu(1)
b=lu(2)
c=lu(3)

rmin=(G*M)^(-1)*(dot(lu,lu))/(1+sqrt(dot(cross(r0,v0),cross(r0,v0))/(G*M)^2*(dot(v0,v0)-2*G*M/sqrt(dot(r0,r0)) +1)));
rmin=rmin/1000

% now for the asymptotic velocity...
A=cross(v0,lu)-G*M*r0/sqrt(dot(r0,r0))
e1=A/sqrt(dot(A,A))
e3=lu/sqrt(dot(lu,lu))
e2=cross(e3,e1)
vinf=sqrt(dot(v0,v0)-2*G*M/sqrt(dot(r0,r0))) %m/s
thetaMax=acos(-1/sqrt(dot(cross(r0,v0),cross(r0,v0))/(G*M)^2*(dot(v0,v0)-2*G*M/sqrt(dot(r0,r0)) +1)))

vinfVector=vinf*(e1*-1/sqrt(dot(cross(r0,v0),cross(r0,v0))/(G*M)^2*(dot(v0,v0)-2*G*M/sqrt(dot(r0,r0)) +1)) ...
    +e2*sin(thetaMax))

v1inf=vinfVector+v20 % Cassini's final velocity m/s

v1inf=v1inf*5.77548327*10^(-7) % final velocity AU/day