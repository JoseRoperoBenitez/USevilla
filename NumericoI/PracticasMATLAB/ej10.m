% Ejercicio 10

%% a)

fa = @(x)(x+1)./(x.^2 -3);
xa = linspace (2,4);
plot (xa,fa(xa));
shg

%% b)

fb = @(x) asin(x-5);
xb = linspace(4,6);
plot (xb,fb(xb));
shg
