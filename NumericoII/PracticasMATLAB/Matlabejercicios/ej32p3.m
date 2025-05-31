function ej32p3

x = linspace (.5, 3*pi);
f = @(x) sin (x./2).*cos(sqrt(x));
Ox = 0*ones(size(x));

plot (x,f(x), x, Ox)

sol1 = fzero (f,[1,4]);
sol2 = fzero (f, [5,9]);

disp (['Las sols son: ', num2str(sol1), ' y: ', num2str(sol2)])