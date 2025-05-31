function [u1,k] = MeIterativo (A,b,u0,Eps)

Nmax = 100;
tol = 1.e-4;

for k = 1:Nmax
    u1 = (b - Eps*A*u0)*.5;
    res = (u1-u0);
    if res < tol
        return
    end
    u0=u1;
end
warning('Numero max de iteraciones alcanzado')