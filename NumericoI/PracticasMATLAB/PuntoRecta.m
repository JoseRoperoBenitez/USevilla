function [bool] = PuntoRecta(x, y)
%
% Creamos un m funcion que devuelve true o false en función de si un punto
% (x,y) esta por encima del punto (5,1) en recta de origen a (x,y).
%
bool = false;
if y/x <= 1/5
    bool = true;
end