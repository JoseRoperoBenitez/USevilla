function [N] = Test(x,y)
%
% Nos devuelve:
% N = 1 si el punto (x,y) está (estrictamente) por encima de
% la recta y = −x + 1
% N = 2 si, además, punto (x,y) está estrictamente por encima de la recta
% y = x
% N = 0 en otro caso
%
N = 0;
if y/x > (y + x - 1)
    N = 1;
elseif y/x > (y - x)
    N = 2;

end
