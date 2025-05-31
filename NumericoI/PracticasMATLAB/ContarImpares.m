function [Nodd] = ContarImpares(v)
%
% recibe como argumento de entrada un vector v de números naturales y 
% devuelve el número de sus componentes que son impares
%
Nodd = 0;
for k = 1:length(v)
    if mod (v(k),2) == 1
        Nodd = Nodd + 1;
    end
end