function Ejemplo10p5

% resolvemos ejercicio 10.5 de los apuntes de MATLAB
close all

% definimos la funcion del segundo miembro del sistema diferencia ordinario
F=@(t,y) [y(2)*y(3);-0.7*y(1)*y(3);-0.51*y(1)*y(2)];

%dato inicial
y0=[0;1;1];

%resolvemos numericamente
ode45(F,[0,5*pi],y0)
shg 

%a priori no sabemos cual es cada recta
legend('y_1','y_2','y_3')

%resolvemos
[ts,ys]=ode45(F,[0,5*pi],y0);

% representamos y_3
figure (2)
plot(ts,ys(:,3),'m')
    legend ('y_3')  %cuidado con confundir escalas