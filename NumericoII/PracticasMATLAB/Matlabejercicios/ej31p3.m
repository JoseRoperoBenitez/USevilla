function ej31p3

x = linspace (0,4);

f = @(x) sin(x)-2*cos(2.*x);
g = @(x) 2 - x.^2;

h = @(x) f(x) - g(x);

plot (x,f(x),'b', x,g(x),'r')

sol= fzero (h, [0,2]);
grid on
hold on

plot (sol,f(sol),'.r','MarkerSize',20)
hold off
disp ('La sol es:')
disp (sol)
shg