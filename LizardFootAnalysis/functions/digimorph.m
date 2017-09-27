function D = digimorph(fname,D)

%hold off;
A = imread(fname);              % Load image as array
imagesc(A);                     % Plot image
axis image; hold all;           % Tell axes to preserve aspect ratio, hold for plotting points

pplot = @(a) plot(a(:,1),a(:,2),'o');   % Anonomous/Inline function to plot markers

if ~exist('D','var');   % If a struct is not supplied, make all measurements
    
    % Calibrate image
    u=0;
    while (u==0);
    units = input('Would you like to calibrate using cm or inches? (type in for inches and cm for centimeters) : ','s');
    if strcmp(units,'cm')
        scale = input('Enter distance between markers in cm: ');
        u=1;
    elseif strcmp(units,'in')
        scale = input('Enter distance between markers in inches: ');
        u=2;
        else
        u=0;
        disp('Incorrect input, input either cm or in in prompt!');
    end
    end
    

    disp('Click two points at known positions for calibration');
    c(1,:)=zin('first calibration point',.9); pplot(c(1,:));
    c(2,:)=zin('second calibration point',.9); pplot(c(2,:)); % Click two points at known positions for calibration
    if u==1
        scale=scale*0.393701; %input calibration distance is now stored in inches
    end
    caldistance = scale*25.4;      % Distance between cal points in mm
    cal = caldistance/sqrt(sum(diff(c).^2,2));

    D.cal = cal;    % Store calibration in output
    D.c = c;    % Store calibration points in output
    
    
    ds = @(p) sqrt(sum(diff(p).^2,2))*cal;  % Anon. function to get real distance between two points
    
    % Digitize each set of markers
    
    u=0;
    while (u==0)
    s=zeros(8,2);
    s(1,:)=zin('tip of head',cal);
    S1(1,:)=zin('left front shoulder marker',cal);
    S1(2,:)=zin('right front shoulder marker',cal);
    s(2,:)=(S1(1,:)+S1(2,:))/2;
    s(3,:)=zin('body',cal);
    disp(['Click on upper body. Start at left front elbow, then click left front shoulder (without marker), ' ...
        'right front shoulder (without marker), then finally right front elbow.(no zoom)']);
    w1=ginput(4);
    reCal=input('Would you like to recalibrate the upper half of the body if there were errors?(type y or n): ','s');
    if strcmp(reCal,'n')||strcmp(reCal,'N')
        u=1;
    else u=0;
    end
    end
    pplot(w1);
    
    while(u==1)
    H2(1,:)=zin('left hind hip marker',cal);
    H2(2,:)=zin('right hind hip marker',cal);
    disp(['Click on lower body. Start at left hind knee, then click left hind hip (without marker), ' ...
        'right hind hip (without marker), then finally right hing knee. (no zoom)']);
    w2=ginput(4);
    s(4,:)=(H2(1,:)+H2(2,:))/2;
    s(5,:)=zin('tail 4',cal);
    s(6,:)=zin('tail 3',cal);
    s(7,:)=zin('tail 2',cal);
    s(8,:)=zin('tail 1',cal);
    reCal=input('Would you like to recalibrate the lower half of the body if there were errors?(type y or n): ','s');
    if strcmp(reCal,'n')||strcmp(reCal,'N')
        u=0;
    else u=1;
    end
    end
    pplot(s)
    pplot(w2);
    

    
    
    while (u==0)
    v(1,:)=zin('tail tip',cal);
    tbVent(1,:)=zin('top of vent',cal);
    tbVent(2,:)=zin('bottom of vent',cal);
    v(2,:)=(tbVent(1,:)+tbVent(2,:))/2;
    reCal=input('Would you like to recalibrate the tail tip and vent of the body if there were errors?(type y or n): ','s');
    if strcmp(reCal,'y')||strcmp(reCal,'Y')
        u=0;
    else u=1;
    end
    end
    
    dc=ds([s(4,:) ; v(2,:)]);
    
    pplot(tbVent);
    pplot(v);
    
    t1Width=[s(7,:); s(8,:); v(1,:)];
    
    %measuring tail widths
    while(u==1)
    wid(1,:)=tailWidth(t1Width, cal, 2);
    wid(2,:)=tailWidth( s, cal, 7 );
    wid(3,:)=tailWidth( s, cal, 6 );
    wid(4,:)=tailWidth( s, cal, 5 );
    wid(5,:)=tailWidth(s, 1.2*cal, 4);
    %wid(6,:)=tailWidth(s, cal, 3);
    %wid(7,:)=tailWidth(s, cal, 2);
    reCal=input('Would you like to recalibrate the widths?(type y or n): ','s');
    if strcmp(reCal,'y')||strcmp(reCal,'Y')
        u=1;
    else u=0;
    end
    end
    
    axis image;

    
    % Store raw click data
    D.s = s;
    D.w1 = w1;
    D.w2 = w2;
    D.v = v; 

    
    % Convert to needed measurements and store
    D.L = ds(s);
    D.front_w = sum(ds(w1));
    D.hind_w = sum(ds(w2));    
    D.tailtip_vent = ds(v);
    D.Widths = wid;
    D.dc=dc;
    
       %write data to file to copy to morphomodel
    date= input('Enter date that photo was taken:','s');
    matOut=input('Enter name of .mat output file:','s');
    outputFile=fopen('outputDigi.txt','w');
    OUT={fname; ['%' date]; ['L=[' num2str(fliplr(D.L')) ']*1e-3;']; ['a=[tail1 tail2 tail3 tail4 hip body head]*1e-3; %heights of various body parts']; ...
        ['b=[' num2str(D.Widths') ' ' num2str(D.hind_w) ' ' num2str(D.front_w) ']*1e-3;']; ['mass_tot= insert;'];['dc=' num2str(D.dc) '*1e-3;'];[' '];['Please copy above to MorphoModel now and/ or save elsewhere...']; ...
        ['.mat filename:' matOut '.mat'];['Please double click ans file in workplace and save as ' matOut '.mat']}
    OUT2=cellstr(OUT)
    [nrows,~]=size(OUT2);
    formatSpec='%s\n';
    for row=1:nrows
        fprintf(outputFile,formatSpec,OUT2{row,:});
    end

else
    % Just plot the points on the image
    pplot(D.c)
    pplot(D.s)
    pplot(D.w1)
    pplot(D.w2)
    pplot(D.v)
    
       %write data to file to copy to morphomodel
    date= input('Enter date that photo was taken:','s');
    matOut=input('Enter name of .mat output file:','s');
    outputFile=fopen('outputDigi.txt','w');
    OUT={fname; ['%' date]; ['L=[' num2str(fliplr(D.L')) ']*1e-3;']; ['a=[tail1 tail2 tail3 tail4 hip body head]*1e-3; %heights of various body parts']; ...
        ['b=[' num2str(D.Widths') ' ' num2str(D.hind_w) ' ' num2str(D.front_w) ']*1e-3;']; ['mass_tot= insert;'];['dc=' num2str(D.dc) '*1e-3;'];[' '];['Please copy above to MorphoModel now and/ or save elsewhere...']; ...
        ['.mat filename:' matOut '.mat'];['Please double click ans file in workplace and save as ' matOut '.mat']}
    OUT2=cellstr(OUT)
    [nrows,~]=size(OUT2);
    formatSpec='%s\n';
    for row=1:nrows
        fprintf(outputFile,formatSpec,OUT2{row,:});
    end
   close all; 
    
end

