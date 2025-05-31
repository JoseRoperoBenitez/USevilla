% Ejercicio 44

f = @(x) sin(x) - 2*cos(2.*x) - 2 + x.^2;
solucionpositiva = fzero (f,0)