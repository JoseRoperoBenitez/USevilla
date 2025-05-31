function [v, lambda] = potenciaestudio (A, u0, Nmax, Eps)

% Construimos la primera iteración

u1 = A*u0;
a = u1(1)/u0(1);

% Construimos el resto de iteraciones:

for k = 2:Nmax
    u0=u1;
    a0 = a;
    u = A*u0;
    a = u1(1) / u0(1);
    if abs(a - a0) < Eps
        lambda = a;
        v = u/lambda^k;
        disp ('Hay convergencia')
        return 
    end
    u0=u1;
    a0=a;
end
warning ('Se ha alcanzado numero de iteraciones.')

