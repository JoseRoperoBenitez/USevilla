function [u,Iter] = Examen22ej1 (A,b,u0,tau,nmax,tol)

u = u0;
for Iter = 1:nmax

    u1 = u + tau*(b-A*u);
    res = norm (u1-u);
    
    if res < tol
        return
    end
    u=u1;
end
warning ('Numero de iteraciones máx alcanzadas.')
