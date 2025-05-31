function ej68est

f = @(t,y) exp(5*t);
[tt,yy] = ode45 (f,[0,1], 1);

exacta = exp(5*tt);
close all

subplot(2,1,1) %2 columnas primera de ellas
plot(tt,yy, 'ro-', tt,exacta, 'b*-')
legend ('aprox ode45', 'exacta')

subplot(2,1,2)
plot (tt,abs (exacta - yy), 'm+-')
legend ('error')
shg