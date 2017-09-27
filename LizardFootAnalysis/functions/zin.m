function s = zin(part,cal)
%ZIN Summary of this function goes here
%   Detailed explanation goes here

    disp(['Click ' part]);
    z=ginput(1);
    axis([z(1)-800*cal z(1)+800*cal z(2)-800*cal z(2)+800*cal])
    disp('Click exact center of target spot')
    s=ginput(1);
    axis image;
    
end

