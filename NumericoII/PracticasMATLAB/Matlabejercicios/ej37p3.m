function ej37p3

x = linspace (-4,6);

f = @(x) x.^2 - 4;
g = @(x) 2*x - .8*x.^2 + 3;

plot (x, f(x), x, g(x))
legend ('f' , 'g')
h = @(x) g(x) - f(x);

x1 = fzero (h,-2);
x2 = fzero (h,2);



Area = integral (h, x1,x2);
disp (Area)