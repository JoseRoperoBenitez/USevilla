function [nf] = factorial (n)
%
% Vamos a crear una funcion que nos calcule el factorial de un n
%
prod = 1;
for k = n:-1:1
    prod = prod * k;
end
nf = prod;