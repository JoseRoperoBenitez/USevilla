function ej16p2

x = [0 2 3 5 6 8 9 11 12 14 15];
y = [10 20 30 -10 10 10 10.5 15 50 60 85];

disp ('integral con trapz: ')
disp (trapz(x,y))

z = (y(1:end-1)+y(2:end))*.5.*(x(2:end)-x(1:end-1));
disp ('integral programada por nosotros: ')
disp (sum(z))