function ej57estudio

x=[1,2,3];
y=[-3,1,3];

coef = polyfit (x,y,2); % 2 es el grado del polinomio.

z = linspace(0,7);
pz = polyval(coef,z);

close all %cerramos posibles graficas anteriores
plot (x,y,'.r', 'MarkerSize', 10) % Pintamos los puntos

hold on

plot (z,pz,'b') % pintamos el polyval

plot ([-1,7], [0,0], 'k') % Eje X
plot([0,0], [-10,4], 'k') % Eje Y

legend ('puntos interpolados', 'p2 pol interpolacion', 'Location','best')
hold off
shg