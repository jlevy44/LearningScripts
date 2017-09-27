    7/4.5
    (1+i)*(2+i)
    1/0 ... infinite
        
    disp (4+4)
    disp (4^3)
    fix(3*(1+0.7))
    
    clc;
    
    sqrt(2);
    
    log(2), log(0.23) ... two operations one line
    
    cos(1.2), atan(-.8)
    
    exp(2+4*i); ... will not display this b/c ;
        
    angle(i)
    abs(1+1i)
    abs(-1)
    round(1.5)
    fix(1.5)
    floor (3.3)
    ceil(3.3)
    exp(2)
    exp(1)
    
    a=[1 2; 3 4+i]
    transpose (a)
    a'
    %hermitian transpose, conjugate and transpose
    a.'
    
    row=[1 2 3 4]
    column=[5;6;7;8]
    c=row'+column
    d=row+column'
    
    s=sum(row)
    p=prod(column)
    
    f = exp(row)
   %b= rand(2,2)
   b=[1 2; 7 8];
   a*b ... this is proper matrix multiplication
   
   a.*b ... this is element wise multiplication
   
   row.*(column')
   
   row*(column)
   
   %figure this one out
   a/b
   
   a^2
   
   o=[ones(1,10)]
   z=zeros(23,1)
   t=o+o
   r=rand(1,45)
   n=nan(1,10)
   var=rand(5,5)
   
   clear all;
   %linear vectors of values
   a=linspace(0,10,5)
   b=0:2:10
   c=1:5
   d=logspace(0,pi,5)
   help logspace;
   
   %indexing
   %a(n) returns nth element, indexing of matrix/vector starts at 1
   
   clear all;
   x=[12 13 6 7];
   a=x(2)
   b=x(2:4)
   c=x(1:end-2)
   
   A=rand(5) ... rand 5x5 mat
       
   d=A(3,4)
   e=A(1:3,1:2)
   %notice how columns are returned out of order
   f=A([1 2 3], [4 3 5])
   
   %grabs first row
   g=A(1,:)
   %grabs third column
   h=A(:,3)
   %replaces first row
   A(1,:)=[1 0 0 0 0];
   g=A(1,:) %you can write stuff after this too
   
   clear all;
   
   vec=[6 7 3 4 5];
   %assigns two variables, grabs min value of vector and
   %its index/position in vector
   [minVal,minInd] = min(vec)
   
   %finds in matrix/vector where it takes on certain values
   ind=find(vec == 7)
   
   %find out how this and ind2sub work???
   help sub2ind;
   
   clear all;
   
   %plotting
   x=linspace(0,10,10000);
   y=sin(x);
   plot(y); %plots y against index?
   plot(x,y);
   
   clear all;
   
   clc;
   
   x=linspace(0,4*pi,100);
   plot(x,sin(x));
   %vector plots
   plot([1 5 3], [2 7 9]); %notice the xy coordinates
   
   help figure;

   Daniel=rand(5,5,2)
   
   