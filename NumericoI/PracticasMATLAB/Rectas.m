function [bool] = Rectas(a,b,c,d) 
%
% devuelve el valor lógico true si las dos rectas son paralelas, 
% y el valor lógico false en caso contrario
%
%  y = ax + b
%  y = cx + d
%
bool = false;
if a == c
    bool = true;
end
