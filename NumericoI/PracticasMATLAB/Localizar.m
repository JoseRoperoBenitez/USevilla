function [N] = Localizar(x, y)
%
%
%
N = 0;
if ((x+y)>=0)&&((x+y)<=1) 
    N = 2;
elseif ((x+y)>=-3)&&((x+y)<=3)
    N = 1;
end

% Poner siempre que salga algo así el caso más restrictivo antes que el
% que menos.

% ESTE ES EL EJERCICIO TEST EN VERDAD.


