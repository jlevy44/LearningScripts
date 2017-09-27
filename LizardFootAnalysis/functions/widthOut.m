function [  ] = widthOut( D )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
load(D);
W=[num2str(D.hind_w) num2str(D.front_w)]

disp(W);


end

