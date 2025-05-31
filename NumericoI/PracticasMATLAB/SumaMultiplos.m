function [s] = SumaMultiplos(v)
%
% recibe como argumento de entrada un vector v de números enteros y 
% devuelve la suma de los elementos de v que sean múltiplos de 3
%
s=0;
for k = 1:length(v)
    if mod (v(k),3) == 0
        s = s + v(k);
    end
end