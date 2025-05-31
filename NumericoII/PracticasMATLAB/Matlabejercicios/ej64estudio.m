function ej64estudio

x = [.9, 1.5, 3, 4, 6, 8, 9.5];
y = [.9, 1.5, 2.5, 5.1, 4.5, 4.9, 6.3];

z = linspace (.5, 10);

plot (x,y,'.r', 'MarkerSize',10)

% Grado 1 ---> RECTA DE REGRESIÓN

coef1 = polyfit(x,y,1);
pz1 = polyval (coef1, z);
hold on
plot(z,pz1,'b')

% Grado 2

coef2 = polyfit(x,y,2);
pz2 = polyval (coef2, z);
hold on
plot(z,pz2,'g')

% Grado 3

coef3 = polyfit(x,y,3);
pz3 = polyval (coef3, z);
hold on
plot(z,pz3,'m')

% Grado 6

coef6 = polyfit(x,y,6);
pz6 = polyval (coef6, z);
hold on
plot(z,pz6,'c')

axis ([.5 10 -6 10])

legend ('puntos interp', 'grado 1', 'grado 2', 'grado 3', 'grado 6', ...
    'Location', 'Best')

disp (['La recta de regresión es: y= ',num2str(coef1(1)),'x + ', ...
    num2str(coef1(2))])
hold off
shg