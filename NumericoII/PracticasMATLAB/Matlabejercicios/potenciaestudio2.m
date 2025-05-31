function [v, lambda, k] = potenciaestudio2 (A,u0,Nmax,Eps)

[u0max,i] = max (abs(u0));
phi = @(v) v(i);
phi0 = phi(u0);

u1= A*u0;
phi1=phi(u1);

for k = 2:Nmax
    u2 = A*u1;
    phi2=phi(u2);
    c10=phi1/phi0;
    c21=phi2/phi1;
    if abs(c21-c10)<Eps
        lambda=phi2/phi1;
        v=u2/lambda.^k;
        return
    end
    u1=u2;
    phi0=phi1;
    phi1=phi2;
end
warning('Nmax de iteraciones alcanzadas sin cumplir test de parada')
lambda=c21;
v=u2/lamba^k;
