function Ejemplo10p3

% resolvemos el ejercicio 10.3 de los apuntes de MATLAB

% cerramos ventanas graficas
close all

%definimos funcion del segundo miembro
fun = @(t,y) -2*y;

%puntos predeterminados
t=0:.1:2;

%resolvemos numericamente
[ts,ys]=ode45(fun,t,10);

%representacion grafica
plot (ts,ys,'b','LineWidth',1.2)

%representamos la sol exacta en los pintos predeterminados
hold on 
plot(t,10*exp(-2*t),'r*')
hold off
legend ('sol. aproximada','sol. exacta')
shg

saveas(gcf,'Ejercicio10p3.pdf','pdf')
saveas(gcf,'Ejercicio10p3.fig','fig')