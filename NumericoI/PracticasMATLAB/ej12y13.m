%% Ejercicio 12 

%% a)
 ya = @(x) sin(1./x.^2);
xa = linspace (0.1,0.2,300);
plot(xa,ya(xa),'k',"LineWidth",2)
title ('grafica del seno')
xlabel ('eje x')
ylabel ('eje y')
shg

%% b)
yb = @(x) log((x.^2)./(x.^2 + 1));
xb = linspace (-1,1);
plot(xb,yb(xb),'y')
title ('grafica del logaritmo')
xlabel('eje x')
ylabel('eje y')
shg

%% Ejercicio 13

f = @(x) exp((x+2)./(3.*x));
g = @(x) log(x.^2 + 5.*x -2);
x = linspace (1,6);
plot (x,f(x),'r',x,g(x),'b');
legend ('y = f(x)','y = g(x)')
shg