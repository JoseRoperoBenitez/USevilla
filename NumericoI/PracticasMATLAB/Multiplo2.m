function [w] = Multiplo2(v)
%
% recibe como argumento de entrada un vector v de números enteros y 
% devuelve un vector w formado por las componentes de v que sean múltiplos
% de 2.
%
w = [];
for k = 1:length (v)
    if mod (v(k),2) == 0
        w = [w, v(k)];
    end
end