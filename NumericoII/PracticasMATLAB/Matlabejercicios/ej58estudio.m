function ej58estudio

x = [0,2,3,5,6,8,9,11,12,14,15];
y = [10,20,30,-10,10,10,10.5,15,50,60,85];

close all % Limpiamos las graficas

plot (x,y, '.r','MarkerSize',10)

n = length(x);
coef = polyfit(x,y,n-1);

z = linspace(min(x), max(x));
pz1 = polyval(coef,z); % Interpolacion global

hold on

plot(z,pz1, 'b')

pz2 = interp1(x,y,z); % Interpolacion a trozos

plot(z,pz2)

legend ('puntos interpolados', 'interpolacion polyval', ...
    'interpolacion interp1', 'Location', 'Best')
shg
