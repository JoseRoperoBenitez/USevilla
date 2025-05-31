function ej35p3

x = linspace (0,15);
f = @(x) cos(x).*cosh(x) +1;

plot (x, f(x))
grid on

sol1 = fzero (f, 10);

sol2 = fzero (f,13);

disp (sol1)
disp (sol2)