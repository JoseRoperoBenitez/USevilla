function ej17p2

f = @(x) x.*sin(4*log(x));

format long
disp ('Aprox por puntos medios: ')
disp (FPuntosmedios (f,.2, 3, 100))

disp ('Aprox por Simpson: ')
disp (FSimpson (f, .2, 3, 100))

disp ('Solución de la integral: ')
disp (integral (f, .2, 3))

