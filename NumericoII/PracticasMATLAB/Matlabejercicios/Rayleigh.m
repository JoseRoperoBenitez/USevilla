function [lambda2] = Rayleigh (A, u0, Nmax, Eps)

[a,k] = max(u0);

for k = 1:Nmax
    lambda1 = dot (u0,A*u0) / dot (u0,u0);
    u1 = A*u0;
    lambda2 = dot (u1,A*u1) / dot (u1,u1);
    if abs (lambda2 - lambda1) < Eps
        v = u1 / lambda2^k;
        return
    end
    u0=u1;
end
warning ('Num de iteraciones maximas.')