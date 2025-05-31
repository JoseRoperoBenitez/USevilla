function ej18p2

f = @(x) x.*exp(-x.^.8) + .2;

format long
disp ('Aprox ptos medios: ')
disp (FPuntosmedios (f,0,8, 100))

disp('Aprox Simpson: ')
disp (FSimpson (f,0,8, 100))

disp ('Valor de la integral: ')
disp (integral (f,0,8))