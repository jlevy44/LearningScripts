a=cell(3,2);
a(:,1)={'Jeffrey';'Josh';'Albert'};
a(:,2)={'cool';'pretty';'nice'};
b=round(2*rand(1)+1)
c=round(2*rand(1)+1)
disp([a{b,1} ' is ' a{c,2} '.']); %remember the brackets!!!