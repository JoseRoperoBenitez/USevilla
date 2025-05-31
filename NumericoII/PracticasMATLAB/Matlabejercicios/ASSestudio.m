function [x1,n] = ASSestudio (x0, Nmax, g, epsilon)

% devuelve aprox de un punto fijo de x = g(x) y el numero de iteraciones

for n = 1:Nmax
    x1 = g(x0);
    if abs (x1 - x0) < epsilon 
        return
    end
   x0=x1;
end
warning ('iteraciones máx sin test de parada. ')
