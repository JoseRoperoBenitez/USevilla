% Ejercicio 46

f = @(x) exp((x+2)./(3*x));
g = @(x) log (x.^2 + 5*x - 2);
h = @(x) f(x) - g(x);
x = linspace (1,6);
hold on 
plot (x, f(x),'r')
plot (x, g(x),'b')

sol= fzero (h,[1,6]);
plot (sol,f(sol),'k.',"MarkerSize", 15)
hold off
shg
