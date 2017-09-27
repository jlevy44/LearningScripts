QIEdat = readtable('/Users/JoshuaLevy/Desktop/ClassesSpring2017/111B/Labs/QIE/QIE.xlsx')
if 1
    aVaryB = {cellfun(@str2num,table2cell(QIEdat(40:58,4:6))),...
    cellfun(@str2num,table2cell(QIEdat(59:77,4:6))),...
    cellfun(@str2num,table2cell(QIEdat(78:96,4:6))),...
    cellfun(@str2num,table2cell(QIEdat(97:115,4:6)))}
    a = {'0' '45' '90' '135'}
    angles = [0. pi/4 pi/2 3*pi/4]
    subplot(211)
    title('Coincidence Rates Dependence on Half-Wave Plate Settings, Fixed \alpha')
    rsq = []
    chisq = []
    for i=1:2
        errorbar(aVaryB{i}(:,1),aVaryB{i}(:,2),aVaryB{i}(:,3),'.')
        [f,gof] = fit(aVaryB{i}(:,1),aVaryB{i}(:,2),sprintf('N*(c1^2*sin(%f)^2*sin(pi*x/180)^2 + c2^2*cos(%f)^2*cos(x*pi/180)^2 + c1*c2/2*cos(p)*sin(2*%f)*sin(2*(x*pi/180)))',[angles(i),angles(i),angles(i)]),'Weights',aVaryB{i}(:,3).^(-2))
        hold on;
        plot(f)
        rsq = [rsq gof.adjrsquare]
        chisq = [chisq sum(((aVaryB{i}(:,2) - arrayfun(@(x)f(x),aVaryB{i}(:,1)))./aVaryB{i}(:,3)).^2)]
    end
     xlabel('\beta (degrees)')
    ylabel('Coincidence Rate (Count per seconds)')
    legend('\alpha = 0 degrees','Fitted Line','\alpha = 45 degrees','Fitted Line')

    subplot(212)
    for i=3:4
        errorbar(aVaryB{i}(:,1),aVaryB{i}(:,2),aVaryB{i}(:,3),'.')
        hold on;
        [f,gof] = fit(aVaryB{i}(:,1),aVaryB{i}(:,2),sprintf('N*(c1^2*sin(%f)^2*sin(pi*x/180)^2 + c2^2*cos(%f)^2*cos(x*pi/180)^2 + c1*c2/2*cos(p)*sin(2*%f)*sin(2*(x*pi/180)))',[angles(i),angles(i),angles(i)]),'Weights',aVaryB{i}(:,3).^(-2))
        plot(f)
        rsq = [rsq gof.adjrsquare]
        chisq = [chisq sum(((aVaryB{i}(:,2) - arrayfun(@(x)f(x),aVaryB{i}(:,1)))./aVaryB{i}(:,3)).^2)]
    end
    chisq = chisq/gof.dfe
     xlabel('\beta (degrees)')
     ylabel('Coincidence Rate (Count per seconds)')
     legend('\alpha = 90 degrees','Fitted Line','\alpha = 135 degrees','Fitted Line')
end
if 0
     bellPureDat = cellfun(@str2num,table2cell(QIEdat(34:37,3:6)))
     C = bellPureDat(2,3)
     dC = bellPureDat(2,4)
     syms d1 d2 d3 c t p dd1 dd2 dd3 dc dt dp a da
     syms f(d1,d2,c)
     f(d1,d2,c) = atan(sqrt((d1-c)/(d2-c)))
     syms df(d1,d2,c,dd1,dd2,dc)
     df(d1,d2,c,dd1,dd2,dc) = sqrt(sum((gradient(f(d1,d2,c)).*[dd1; dd2; dc]).^2))
     syms ph(d3,t,c,a)
     ph(d3,t,c,a) = acos(1/sin(2*t)*(4*(d3-c)/(a)-1))
     syms dph(d3,t,c,a,dd3,dt,dc,da)
     dph(d3,t,c,a,dd3,dt,dc,da) = sqrt(sum((gradient(ph(d3,t,c,a)).*[dd3;dt;dc;da]).^2))
     N = [bellPureDat(2,3:4);bellPureDat(1,3:4);bellPureDat(3,3:4);bellPureDat(4,3:4)] %C,d1,d2,d3
     A = [N(2,1)+N(3,1)-2*N(1,1), sqrt(N(2,2)^2 + N(3,2)^2 + 4*N(1,2)^2)]
     theta = double([f(N(2,1),N(3,1),N(1,1)) df(N(2,1),N(3,1),N(1,1),N(2,2),N(3,2),N(1,2))])
     phi = double([ph(N(4,1),theta(1),N(1,1),A(1)) dph(N(4,1),theta(1),N(1,1),A(1),N(4,2),theta(2),N(1,2),A(2))])
     A = [N(2,1)+N(3,1)-2*N(1,1), sqrt(N(2,2)^2 + N(3,2)^2 + 4*N(1,2)^2)]
     theta = theta*180/pi
     phi = phi*180/pi
    a=1
end
if 0
    %day1
    Nt = {cellfun(@str2num,table2cell(QIEdat(118:133,5:6))) cellfun(@str2num,table2cell(QIEdat(136:151,5:6)))}%[101 571.1 571.3 212.9; 520.1 90 154.1 643.5; 476.4 210.7 127.1 646.5;  514.4 100.2 95.7 719.2]
    %Ns = sym('N%d%d', [4 4])
    syms S(N1,N2,N3,N4,N5,N6,N7,N8,N9,N10,N11,N12,N13,N14,N15,N16) 
    syms dS(N1,N2,N3,N4,N5,N6,N7,N8,N9,N10,N11,N12,N13,N14,N15,N16,dN1,dN2,dN3,dN4,dN5,dN6,dN7,dN8,dN9,dN10,dN11,dN12,dN13,dN14,dN15,dN16)
    S(N1,N2,N3,N4,N5,N6,N7,N8,N9,N10,N11,N12,N13,N14,N15,N16) = -(N1 - N2 - N3 + N4)/(N1 + N2 + N3 + N4) + (N5 - N6 - N7 + N8)/(N5 + N6 + N7 + N8) +...
        (N9 - N10 - N11 + N12)/(N9 + N10 + N11 + N12) + (N13 - N14 - N15 + N16)/(N13 + N14 + N15 + N16)
    dS(N1,N2,N3,N4,N5,N6,N7,N8,N9,N10,N11,N12,N13,N14,N15,N16,dN1,dN2,dN3,dN4,dN5,dN6,dN7,dN8,dN9,dN10,dN11,dN12,dN13,dN14,dN15,dN16) = sqrt(sum((gradient(S(N1,N2,N3,N4,N5,N6,N7,N8,N9,N10,N11,N12,N13,N14,N15,N16)).*[dN1;dN2;dN3;dN4;dN5;dN6;dN7;dN8;dN9;dN10;dN11;dN12;dN13;dN14;dN15;dN16]).^2))
    
    for j = 1:2
       
        N = 10*Nt{j}(:,1);
        disp(N);
        dN = 10*Nt{j}(:,2);
        a=1;
        Sf = double([S(N(1),N(2),N(3),N(4),N(5),N(6),N(7),N(8),N(9),N(10),N(11),N(12),N(13),N(14),N(15),N(16)) dS(N(1),N(2),N(3),N(4),N(5),N(6),N(7),N(8),N(9),N(10),N(11),N(12),N(13),N(14),N(15),N(16),dN(1),dN(2),dN(3),dN(4),dN(5),dN(6),dN(7),dN(8),dN(9),dN(10),dN(11),dN(12),dN(13),dN(14),dN(15),dN(16))])
%         E = []
%         for i=1:4
%             E =[E, (N(i,1) + N(i,4) - N(i,2) - N(i,3))/sum(N(i,:))]
%         end
% 
%         S = sum(E) - 2*E(1)
    
    
    end
    %day2
    
end