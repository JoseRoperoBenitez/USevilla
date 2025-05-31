function [x1, Iter] = AASSvectorizadoest (g, x0, Nmax, Eps)

for Iter = 1:Nmax
    x1 = g(x0);
    res = norm(x1-x0);
    disp (['Iteración:', num2str(Iter), ' residuo:', num2str(res)])
    if res < Eps
        
        return
    end
    x0=x1;
    
end
warning ('Numero de iteraciones maximas alcanzado.')
