function [fx] = atrozos(x)
%
% la funcion fx dado x ∈ R,
% queremos que devuelva el valor en x de la función definida a trozos
%
fx = x;
if x < 0 
  fx = 3*x.^2; 
end
