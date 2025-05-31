function ej61estudio

M = load ('DatosSpline.dat');

x = M(:,1);
y = M(:,2);

n = length(x);

coef = polyfit(x,y,n-1);

z = linspace (min(x), max(x));
pz1 = polyval (coef,z);

plot(x,y,'.r', 'MarkerSize', 10)

hold on

plot(z,pz1, 'b')

pz2 = spline(x,y,z);
plot(z,pz2, 'g')

legend('Puntos interpol', 'Interpol global', 'Spline cúbico')

shg

