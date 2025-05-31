function ej38p3
% Ejercicio 38

f = @(t) t.*sin((5*t).^0.5);
g = @(t) -1*t+0.5;

t = linspace (0,10);
% ft = f(xj);
% gt = g(t);
h = @(t) f(t)-g(t);
habs = @(t) abs (h(t));

plot (t,f(t), t, g(t))

% Identificamos tres cortes de gráficas, para el cálculo de la integral
% tenemos dos posibles formas de calcularlo:

% a) 

sol1 = integral (habs,0,10);
disp ('El valor de la integral tomando el valor abs: ')
disp (sol1)

% b) 

c1 = fzero (h,0.5);
c2 = fzero (h,3.5);
c3 = fzero (h,5.5);
sol2 = -integral (h,0,c1) + integral(h,c1,c2)-integral (h,c2,c3)+ ...
    integral (h,c3,10);
disp ('El valor de la intengral separadas por puntos de corte: ')
disp (sol2)



