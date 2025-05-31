function Ejemplo10p2

% resolvemos el ejemplo 10.2 de los apuntes de MATLAB

close all %cerramos ventanas graficas

%definimos la fun del segundo miembre
f = @(t,y) t*exp(t/y);

%resolvemos numericamente
[ts,ys]=ode45(f,[0,0.632],1);
ys(end) %para ver el valor en 0.632

%tambien lo podemos hacer:
[ts1,ys1]=ode45(f,[0,1],1);
ysol = @(t) interp1(ts1,ys1,t); % fun anonima que nos da el valor de la edo en cualquier punto
ysol(0.632)