function ej34p3

x = linspace (-0,10);

f = @(x) log(x+1)./(x.^2 + 1);
g = @(x) x.^2 - 8*x + 6;

plot (x,f(x), x, g(x))

h = @(x) f(x) - g(x);

sol1 = fzero (h,0);

sol2 = fzero (h, 6);

disp(sol1)
disp(sol2)