function Ejercicio11p1
% Practicas segundo parcial

% Para los problemas de contorno vamos a usar:

% sol = bvp4c(odefun,ccfun,initsol)

% el initsol es el que nos da como en fzero una primera aprox sobre sobre
% está la sol. Sin embargo esto no se puede ver graficamente, se hace: 

% initsol = bvpinit(xinit, yinit)
% en principio xinit es discretizacion del intervalo. xinit= linspace(a,b)

% el sol va a guardar muchas cosas, con comandos se puede sacar cosas.

% Primer ejemplo

% Resolvemos ahora Ejercicio 11.1 de los apuntes de MATLAB

%funcion del segundo miembro
fun = @(x,y) [3*y(1)-2*y(2); -y(1) + 0.5*y(2)];

%condiciones de contorno
condcon = @(ya,yb) [ya(1);yb(2)-pi];

%aproximacion inicial
xinit = linspace(0,1,5);
yinit=[0;pi]; % son las triviales de las cond de contorno
solinit=bvpinit(xinit,yinit);

% resolvemos numericamente
sol = bvp4c(fun,condcon,solinit);

% representacion grafica

% plot(sol.x,sol.y)

xx = linspace(0,1); %representacion final de la solucion
yy = deval(sol,xx);
plot(xx,yy)
legend('y_1','y_2','Location','Best')

shg

% sol.x' % (le hemos dado una pista de 5 ptos y el ha construido 10)
% sol.y'
