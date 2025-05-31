function [flag] =  DosCirculos (x,y)
%
% Lo hacemos con las condiciones del EJ 23
%
if x^2 + y^2 <= 1
    flag = 1;
elseif (x-7)^2 + y^2 <= 1
    flag = 2;
else 
    flag = 0;
end


