% Ejercicio 41

f = @(x) x-1 + log(x.^2 + 1);
raiz = fzero (f, [0,1]);
x = linspace (0,1);
plot (x,f(x))
hold on 
plot ([0,1],[0,0])
plot (raiz, f(raiz))
hold off
shg

% Falta el pto

%% Ejercicio 42

f2 = @(x) x + log (x+1) - 2;
solucion = fzero (f2, [1,2]);

%% Ejercicio 43

f3 = @(x) 2.^x - x - 3;
solf3 = fzero (f3, [-3,3]);

% No me carga