%differential equations

%ODE solver
%ode23
    %low order solver, use over small intervals
%ode45
    %high order solver, high accuracy+speedy
%ode15s
    %use when diffeq has time constants that vary by order of magnitude
%[t,y]=ode45('myODE',[0,10],[1;0])
        %type( ODE function, time range, initial condition) 
%p.28 research this lect3

%[t,y]=ode45('chem',[0 0.5],[0 1]);
[t,y]=ode45('chem',[0:0.001:0.5],[0 1]); %middle is fixed timestep, vector of specified times
plot(t,y(:,1),'k','LineWidth',1.5);
hold on;
pause;
plot(t,y(:,2),'r','LineWidth',1.5);
legend('A','B');
xlabel('Time (s)');
ylabel('Amount of chemical (g)');
title('Chem reaction');

figure;
[t,x]=ode45('pendulum',[0,10],[0.9*pi 0]);
x %x=[position is col1,velocity is col2]=[theta,gamma], gamma=dtheta/dt
%the x has been specified in such a way in the function pendulum
%x=[theta,gamma]
t %t=time for each position and velocities
plot(t,x(:,1));
hold on;
plot(t,x(:,2),'r');
legend('Position','Velocity');
figure;
plot(x(:,1),x(:,2)); %x(:,1) uses all entries of column 1
xlabel('position'); %this is a phase plane
ylabel('velocity');

%p.35
options=odeset('RelTol',1e-6,'AbsTol',1e-10);
[t,x]=ode45('pendulum',[0,10],[0.9*pi 0],options);
%^^^error @ each step less than RelTol times the value @ that step
%error<RelTol*value or error<AbsTol
%making err smaller slows solver

[t,y]=ode45('eyyy',[0,10],10);
[t,y]=ode45(@(t,y) -t*y/10,[0 10],10);
y
figure;
plot(t,y(:,1));
hold on;
dydt=diff(y)./diff(t);
plot(t(1:end-1),dydt,'r');
xlabel('Time');
ylabel('Position/Velocity');
legend('Position','Velocity');
pause;
close all;
