function [n] = SumaImpares
%
% n = SumaImpares es el mayor numero impar tal que la suma de todos
% los impares desde 1 hasta n es < = 5000
%
suma = 0;
n = 1;
while suma <= 5000
    suma = suma + n;
    n = n+2;
end
n = n-2;

% EL BUCLE WHILE SE CORTA CUANDO JUSTO NO CUMPLE LA CONDICIÓN. POR ELLO, AL
% FINAL DEL TODO PONGO EL N = N-2 PARA OBTENER EL ÚLTIMO NÚMERO QUE CUMPLE
% LA CONDICIÓN.

% En el for te hace solo los cambios de valor, en el while hay que irlos
% poniendo.










% Para hacer por ejemplo una suma de números hasta un valor vamos a usar el
% operador while.