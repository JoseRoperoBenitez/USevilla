%% Funciones básicas para el dibujo de curvas

%% Forma 1
x = linspace(-2,3);
y = (x.^2+2)./(x+5);
plot(x,y)
shg

% ¡¡¡¡AQUI SI ES IMPORTANTE LOS PUNTOS SIEMPRE!!!!!

% Si solo tengo esta función y pongo en la venta de comando Ejclase2parte2
% te sale del tirón.

%% Forma 2

fun1 = @(x) (x.^2+2)./(x+5);
x = linspace(-2,3);
plot(x,fun1(x))
shg

% Es mejor hacerlo de esta forma de cara a futuros ejercicios.

% Para representar varias funciones podemos hacerlo asi:
% plot (x1,y1,x2,y2,x3,y3).


