function [u,Iter] = Jacobi (A,b,u0,Nmax,Eps)

diagA = diag (A);
u = u0;
for Iter = 1:Nmax
    res = (b-A*u0)./diagA;
    u1 = u0 + res;
    if norm(u1-u0)<Eps
        return
    end
    
    u0=u1;
end
warning ('fin de Nmax iteraciones sin cumplirse test de parada')

% HAY QUE COMPROBAR LA SOLUCION CON EL u= A\b