function [tr] = Traza(A)
%
% Traza(A) es la suma de los elementos diagonales de la
% matriz cuadrada A
%
[n,m] = size(A);
if n ~= m
error('La matriz no es cuadrada')
end
tr = 0;
for k = 1:n
tr = tr + A(k,k);
end
