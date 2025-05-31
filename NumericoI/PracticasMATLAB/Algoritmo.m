function [bool] = Algoritmo (x,y,r)
%
% recibe dos vecotores de misma dim y un numero r. Devuelve true si unu de
% los puntos (x_i, y_i) esta fuera de cuadrado (cerrado) [-r,r]x[-r,r]
%
bool = false;
a = r^2;
if length(x) == length (y)
    for k = 1:length (x)
        if x(k)^2 + y(k)^2 > a
            bool = true
        end
    end
end