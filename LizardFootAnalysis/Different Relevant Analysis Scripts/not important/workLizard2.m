clear all;
load ('LizardBuild.mat'); %will be input from function input
s=size(B);


for n=1:s(2)
    for l=1:4
        struct HO HI FO FI;
        if strcmp(B(n).feet(l).foottype,'HI') 
            HI(n)=B(n).feet(l); end; 
        if strcmp(B(n).feet(l).foottype,'FO') 
            FO(n)=B(n).feet(l); end; 
        if strcmp(B(n).feet(l).foottype,'FI') 
            FI(n)=B(n).feet(l); end; 
        if strcmp(B(n).feet(l).foottype,'HO') 
            HO(n)=B(n).feet(l); end; 
    end;
end;

for n=1:s(2)
        z=1;
    for m=1:2:length(HO(n).times)-1
        HO(n).int(z,:)=(HO(n).times(m:m+1))'; 
        z=z+1; 
    end;
        HO(n).numStrides=z-1;
         z=1;
    for m=1:2:length(HI(n).times)-1
        HI(n).int(z,:)=(HI(n).times(m:m+1))'; 
        z=z+1; 
    end;
        HI(n).numStrides=z-1;
        z=1;
    for m=1:2:length(FI(n).times)-1
        FI(n).int(z,:)=(FI(n).times(m:m+1))'; 
        z=z+1; 
    end;
        FI(n).numStrides=z-1;
        z=1;
    for m=1:2:length(FO(n).times)-1
        FO(n).int(z,:)=(FO(n).times(m:m+1))'; 
        z=z+1; 
    end;
        FO(n).numStrides=z-1;
end;

T=[0,1;-1,0];
for n=1:s(2)
    P7=B(n).MarkerPos{7};
    P6=B(n).MarkerPos{6};
    P5=B(n).MarkerPos{5};
    R6=B(n).R{6};
    R5=B(n).R{5};
    
    for m=1:B(n).num_samples
        Yf=P7(m,:)-P6(m,:);
        yf(m,:)=Yf/sqrt(Yf*Yf');
        Yr=P6(m,:)-P5(m,:);
        yr(m,:)=Yr/sqrt(Yr*Yr');
        xf(m,:)=(T*yf(m,:)')';
        xr(m,:)=(T*yr(m,:)')';
    end;
        
    
    XYRdat.xf{n}=xf;
    XYRdat.yf{n}=yf;
    XYRdat.xr{n}=xr;
    XYRdat.yr{n}=yr;
    XYRdat.Rfront{n}=R6;
    XYRdat.Rrear{n}=R5;
    clear xf yf xr yr l;
end;


HO=time2Frames(HO,B);
HI=time2Frames(HI,B);
FO=time2Frames(FO,B);
FI=time2Frames(FI,B);
% input HO, h, XY, B, which R, which x and y
%only defined for front function, please generalize and change!!! need to
%include rear
FO=pos(FO,B,XYRdat,'front');
FI=pos(FI,B,XYRdat,'front');
HO=pos(HO,B,XYRdat,'rear');
HI=pos(HI,B,XYRdat,'rear');

for n=1:s(2)
relfootdat(n).HO=HO(n).relpos;
relfootdat(n).HI=HI(n).relpos;
relfootdat(n).FO=FO(n).relpos;
relfootdat(n).FI=FI(n).relpos;
end;
        

        