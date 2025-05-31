function [fx] = Trozos (x)
%
% devuelve el valor en x de la función definida a trozos:
% 
% (x^2 − 2) si x ≤ −2
% (ln(x + 3)) si − 2 < x < 3
% (1/x) si x ≥ 3.
%
fx = x.^2 - 2;
if (x> 2)&&(x<3)
    fx = log(x+3);
elseif (x>=3)
    fx = 1/x;
end


% DUDA: Cual es la primera función que ponemos?