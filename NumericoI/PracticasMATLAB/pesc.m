function n = pesc (u,v)
%
% Vamos a realizar el producto escalar entre dos vectores
%
suma = 0;
m = length (v);
for i = 1: m
    suma = suma + u(i)*v(i);
end
n = suma;