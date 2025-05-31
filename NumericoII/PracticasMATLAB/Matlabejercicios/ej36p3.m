function ej36p3

x = linspace (0,9);
f = @(x) sin(4.*log(x+1));

ox = @(x) 0*ones(size (x));

plot (x,f(x), x, ox(x))
grid on

x1 = fzero (f,1);
x2 = fzero (f, 3);

g = @(x) -1*f(x);

A1 = integral (f, 0,x1);
A2 = integral (g, x1,x2);
A3 = integral (f,x2,9);

A = A1 + A2 + A3;
disp ('El área total es: ')
disp (A)



