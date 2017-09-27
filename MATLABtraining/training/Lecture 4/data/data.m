%matrices must have same data type
a=zeros(100); %matrix 100by100
a(1,3)=10; a(21,5)=pi; b=sparse(a) %creates sparse matrix ???
%cell array-> elements do not have to be same type
%struct- bundle var names and values into one structure

%initialize cell array
a=cell(3,10);
%or use curly brackets
c={'hello world',[1 5 6 2], rand(3,2)}
% to access
a{1,1}=[1 3 4 -10];
a{2,1}='hello world 2';
a{1,2}=c{3};
disp(a);


% structure
s=struct; 
%initialize 1x1,meaning there is one object with many properties
s.name= 'Joshua Levy';
s.scores = [95 98 67];
s.year = 'G3';
disp(s);
ppl=struct('name',{'John','Mary','Leo'}, ...
    'age',{32,27,18},'childAge',{[2;4],1,[]});
size(ppl)
disp(ppl(1));
person=ppl(1); %*****
person.name %this is still fragmented with a built in structure
ppl(2).age
disp(['child age is ' num2str(ppl(1).childAge')]);

%accessing structure fields
stu=s.name;
scor=s.scores;
person=ppl(1);
personName=ppl(1).name
personName=person.name
a=[ppl.age] %vector of ages, may have to concatenate


