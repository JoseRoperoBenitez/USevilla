function ej33p3

x = linspace(-10,2);

f = @(x) (x.^2 -1).* exp(x/2);
g = @(x) ((x+2).^2)/10  - 1;

plot (x,f(x), x, g(x))

h = @(x) f(x) - g(x);

sol1 = fzero (h,-8);
sol2 = fzero (h, -2);
sol3 = fzero (h,.5);

disp (['Las sols son: ', num2str(sol1), ' , ', num2str(sol2), ' y ', ...
    num2str(sol3)])