function [u1, Iter] = relajacionestudio (A,b,u0,Nmax,Eps,w)

n = length (b);

% Primero nos aseguramos que la matriz es no singular

for i = 1:n
    if abs(A(i,i))<10.e-6
        error ('La matriz es singular')

    end
end

% Pasamos a definir las iteraciones

u1 = zeros(n,1);

for Iter = 1:Nmax
    for i = 1:n
        u1(i) = u0(i) + (b(i) - dot (A(i,1:i-1), u0(1:i-1)) - ...
            dot (A(i,i:end), u0(i:end))).* (w/A(i,i));
    end
    res = norm (u1-u0);
    if res < Eps
        return
    end
    u0=u1;
end
