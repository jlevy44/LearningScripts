function [ dydt ] = chem( t,y)
%chem reaction ode function
dydt=zeros(2,1);
dydt(1)=-10*y(1)+50*y(2);
dydt(2)=10*y(1)-50*y(2);

end

