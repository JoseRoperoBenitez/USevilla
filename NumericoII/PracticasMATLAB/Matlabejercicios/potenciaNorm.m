function [v,lambda,k]=potenciaNorm(A,u0,phi,Nmax,Eps)
v0=u0/norm(u0);
u1=A*v0;
v1=u1/norm(u1);
phiv0=phi(v0);
phiu1=phi(u1);
phiv1=phi(v1);

for k=2:Nmax
    u2=A*v1;
    phiu2=phi(u2);
    c10=phiu1/phiv0;
    c21=phiu2/phiv1;
    if abs(c21-c10)<Eps
        lambda=phiu2/phiv1;
        v=v1;
        return
    end
    v1=u2/norm(u2);
    phiv0=phiv1;
    phiu1=phiu2;
    phiv1=phi(u2/norm(u2));
end
warning('Nmax de iteraciones alcanzadas sin cumplir test de parada')
lambda=c21;
v=v1;