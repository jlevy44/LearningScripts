%helloworld.m
%This is my first app Hello World

    disp ('helloWorld!');
    disp ('I am going to learn Matlab!');

    var1 = 3.14
    disp (var1);

    row1 = [4.5 2.2 5.7]
    col1 = [4.5; 5.3; 6.7; 2.4]
    
    disp (col1);
    %this will be declared assigned and outputted
    size1 = size (col1)
    disp (size(col1));
    %putting a semicolon supresses output!
    length1 = length (row1);
    disp (length1);
    
    mat1 = [1 3; 5 7]
    disp (mat1);
    disp ([mat1; mat1]);
    mat2 = ['this is a string' 'matrix'];
    disp (mat2);
    disp(size(mat1));
    %save variables to file, must be in right directory
    save hello length1 col1
    %this will clear variables from workspace on left
    clear length1 col1
    %clear myenv
    %clear all
    %returns variables length1 and col1 which were saved to hello
    load hello
    save myenv
    clear all
    %load myenv  << this loads back all workspace
    
    %exercise
    %TIC TOC functions time an event, clock is actual time, fix(clock) rounds
    %clock to nearest integer, vector clock = [year month day hour minute seconds]
    help clock
    start= fix(clock);
    disp (start);
    %how to get expressions to appear side by side?
    disp ('size of row vector start= ');
    disp(size(start));
    %converts vector into string
    startString= datestr(start);
    %displaying string in vector form
    disp(['the date and time is ' startString]);
    save startTime start startString;
    help datestr;
    clear all;
    
    %new exercise
    %you can only load what variables have been stored in a file
    
    load startTime;
    help help;... you can type after these dots and nothing happens
    disp(['I started learning matLAB on ' startString]);
    
    %new exercise
    tau= 1.5*24*3600;
    endOfClass= 5*24*3600;
    help num2str;
    %exp(#)= e^(#)
    %convert number to string using num2str(#,N) where N is number of
    %digits
    knowledgeAtEnd=num2str((1-exp((-1)*endOfClass/tau))*100,4)
    %the ... also lets you go to another line during a line of code
    disp(['At the end of 6.094, I will know ' ... 
        knowledgeAtEnd '% of MATLAB']); 
    
    %new exercise
    secPerMin=60;
    secPerHour=3600;
    secPerDay=24*secPerHour;
    secPerMonth=30.5*secPerDay;
    secPerYear=12*secPerMonth;
    secondConversion=[secPerYear secPerMonth secPerDay secPerHour ...
        secPerMin 1];
    currentTime=clock;
    elapsedTime=currentTime-start;
    t=secondConversion*elapsedTime'
    clear knowledgeAtEnd;
    knowledgeAtEnd=num2str((1-exp(-t/tau))*100,4);
    disp(['At this time, I know ' ... 
        knowledgeAtEnd '% of MATLAB']);
    tVec=linspace(0,endOfClass,10000);
    knowledgeVec=(1-exp(-tVec/tau)) %in decimal form here, not %
    
    %new exercise
    [minVal,minInd]=min(abs(knowledgeVec-0.5));
    halfTime=tVec(minInd);
    %remember conversions and to make it a string MATRIX
    disp(['I will know half of MATLAB after ' ...
        num2str(halfTime/secPerDay) ' days']);
    
    figure;
    %tVec is x, knowledge vec is y, remember unit conversion
    plot(tVec/secPerDay,knowledgeVec);
    %end lecture 1
    