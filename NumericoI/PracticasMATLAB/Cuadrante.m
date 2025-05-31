function [n] = Cuadrante(x, y)
%
% n = Cuadrante(x, y) es el número del cuadrante del plano OXY
% en el que se encuentra el punto (x,y).
% 2 | 1 n = 0 si el punto está sobre uno de los ejes.
% -- --
% 3 | 4
%
if x*y == 0
    n = 0;
    return
end
if (x>0)
    n = 4;
    if(y>0)
        n = 1;
    end
else 
    n = 3;
    if (y>0)
        n=2;
    end
end
