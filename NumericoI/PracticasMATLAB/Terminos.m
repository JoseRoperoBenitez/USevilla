function [suma] = Terminos(x, n)
%
% recibe como argumento de entrada un número positivo x y un número natural
% n y devuelva la suma de los n primeros términos de la sucesión
% ak =1 + x^k / 2kx^2 k ≥ 1 (k lo llamaremos aux)
%
suma = 0;
aux = 1;
for k = 1:n
    aux = aux*x;
    suma = suma+ (1 + aux)/k;
end
suma = suma/(2*(x^2));

% Duda pq el terminos se divide asi por el k.