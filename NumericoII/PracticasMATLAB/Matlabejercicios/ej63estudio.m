function ej63estudio

x = [0,2,3,5,6,8,9,11,12,14,15];
y = [10,20,30,-10,10,10,10.5,15,50,60,85];

close all %Cerramos anterior
n = length(x);
z = linspace (min(x), max(x));

plot(x,y,'.r','MarkerSize', 10)

%Pol interpol global

coef = polyfit(x,y,n-1);
pig = polyval (coef,z);

hold on
plot(z,pig,'b')

%Pol interpol lineal a trozos

plt = interp1(x,y,z);
plot(z,plt,'g')

%Spline cúbico

coefspl = spline(x,y);
spl = ppval(coefspl, z);

plot(z,spl,'k')

% Calculamos ahora el valor interpolado para z=1:

pig1 = polyval(coef,1);
disp(['Valor con i. global: ', num2str(pig1)])

plt1 = interp1(x,y,1);
disp (['Valor con i. l. a trozos: ', num2str(plt1)])

spl1 = ppval(coefspl, 1);
disp(['Valor con spline: ', num2str(spl1)])

plot ([1,1,1], [pig1,plt1,spl1], 'k.', 'MarkerSize', 20)

%Leyenda
legend ('puntos interp', 'inter. global', 'inter. l. a trozos', ...
    'spline cúbico','z=1', 'Location', 'Best')