function Ejemplo10p7

%ejercicio 10.7

close all

%hacemos en papel el cambio de variable

%escribimos segundo miembro del sistema equivalente
F=@(t,z) [z(2);-7*sin(z(1))-0.1*cos(t)];

z0=[0;1];

%resolvemos numericamente
[ts,zs]=ode45(F,[0,5],z0);

%lo que realmente me estan pidiendo es y. En ESTE CASO ES z1=y

% sol de la edo
ys = zs(:,1);

%representacion grafica de la sol de la edo
plot(ts,ys)
shg
legend('sol.edo')