function [v] = Orden(n1, n2)
%
% v = Orden(n1, n2) es un vector que contiene los dos
% numeros n1 y n2 ordenados en orden creciente
%
if n1 > n2
v = [n2, n1];
else
v = [n1, n2];
end

