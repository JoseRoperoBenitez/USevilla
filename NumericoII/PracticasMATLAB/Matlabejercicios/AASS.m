function [x1,n] = AASS (x0,Nmax,g,epsilon)

% >> [x1,n] = AASS (x0,Nmax,g,epsilon) Ej 25
% >> [x,n] = AASS (1,100,@(x) -log(x/3), 1e-4) EJERCICIO 30, la fun es de
% punto fijo, x = g(x)
for n = 1:Nmax
    x1 = g(x0);
    if abs (x1-x0)<epsilon
        return
    end
    x0=x1;
end
warning ('iteraciones máximas completas sin test de parada. ')