%% Ejemplo 3.20

f = @(x) exp(-x) + sin(x.^2)-x;
g = @(x) exp(x) + sin(x.^2) + x;
xf = linspace (-2,6);
xg = linspace (-6,2);

plot ( xf,f(xf),'r<', xg, g(xg), 'bo-' ) 

axis ([-2,4, -5,4])
title ('dos graficas')
legend ('grafica f', 'grafica g')
xlabel ('eje x')
ylabel ('eje y')
shg

% el axis con xmin xmax, ymin,ymax es para poner los ejes como queramos
% verlo.
% ES recomendable mirar la tabla (3.1,3.2) de los colores y esas cosas.
% Se puede poner en la ventana de comandos también el help plot.

% IMPORTANTÍSIMO EL TITLE; LEGEND, XLABEL, YLABEL.

%% Ejemplo 3.22

t = linspace(0, 2*pi);
x = -1 + 2*cos(t);
y = 4 + 2*sin(t);
plot (x,y,'LineWidth',2, 'Color', [0.3 0.85 0.6])
axis equal


shg

% El axis equal es para que nos deje los ejes en la misma escala.

% SI  no quiero que se vean los ejs de la grafica ponemos 
% axis off.
% Para seguir pintando en una grafica ya pintada podemos usar el HOLD ON.

% QUedaría algo así

% hold on 
% v = linspace (0,3);
% yv = y.^2;
% plot (v,yv);
% hold off (para que solo haga este plot)


%% Otro ejemplo de apuntes.


f = @(x) 0.5*x.*sin(x.^2);
x = linspace(-4, 4,300);
axis([-4, 4, -2, 2])
hold on
plot(x, f(x), 'LineWidth', 2)
plot([-4, 4], [0, 0], 'k', 'LineWidth', 1.5)
plot([0,0], [-2, 2], 'k', 'LineWidth', 1.5)

plot (0,0,'r.','MarkerSize', 15, 'LineWidth', 3)

hold off
axis on
shg

% EL plot ese suelto es para hacer el punto (0,0).





