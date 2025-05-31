function Bratu(Lambda)

% Ejercicio 20 de la relacion de ejercicios, problema de Bratu
% u'' + lambda*exp(u)=0 en (0,1)
% u(0)=u(1)=0
% El problema tendrá dos, una o ninguna solución dependiendo del valor
% de lambda

%hacemos en primer lugar a mano el cambio de variable habitual

% función segundo miembro del SDO

fun=@(x,y) [y(2);-Lambda*exp(y(1))];

% condiciones de contorno
condcon = @(ya,yb) [ya(1);yb(1)];

% aproximacion inicial
xinit = linspace(0,1,20); %el problema tiene cierta singularidad, por lo q 
                          %le damos mas puntos
% yinit = [0;0]; es una inicialización MALA
yinit1 = [0.1;0];
yinit2 = [1.5;0];  % necesitamos dos pq nos dice el problema que puede tener 
                 % dos sols una o ninguna en funcion de lambda

solinit1 = bvpinit(xinit,yinit1); %solucion inicial 1
solinit2 = bvpinit(xinit,yinit2); %solucion inicial 2

% mejoramos opciones de resolución numérica
op=bvpset('stats','on','RelTol',1.e-4);

% resolvemos numericamente
sol1 = bvp4c (fun,condcon,solinit1,op);
sol2 = bvp4c (fun,condcon,solinit2,op);

% representacion grafica
close all
xx=linspace(0,1);
y1= deval(sol1,xx,1);
y2= deval(sol2,xx,1);

plot(xx,y1,'b', xx,y2,'g')
title (['soluciones del problema de Bratu para \lambda', num2str(Lambda)])

% hay que saber interpretar los resultados pq si ponemos por ejemplo 3.7 
% nos hace un dibujo y esto no tendria sentido
% ojo con lo que hace y como se van aproximando las dos rectas

%podemos ir probando para obtener un valor critico me sale aprox con 3.518
% puede variar si cambiamos el 1.e-4 por 1.e-5

% solds exacta
[y1,y2] = exacta(Lambda);

ex1= y1(sol1.x);
ex2= y2(sol2.x);

hold on
plot(sol1.x,ex1,'r*',sol2.x,ex2,'y*')
hold off
legend('Sol1 aprox', 'Sol2 aprox','Sol1','Sol2')

% si pusieramos un 3.8 no da soluciones exactas pq el fzero no hace nada ya
% que no hay soluciones teoricas
end

function [y1,y2] = exacta(lambda)
% calculamos las soluciones exactas del problema de Bratu.

fun = @(alpha) cosh(alpha)-4*alpha/sqrt(2*lambda);

%gráfica
%figure(2)
x = linspace (0,3);
fx = fun(x);
% plot(x,fx)
grid on

alpha1 = fzero(fun,0.5);
alpha2 = fzero(fun,2);

y1 = @(x) 2*log(cosh(alpha1)./cosh(alpha1*(1-2*x)));
y2 = @(x) 2*log(cosh(alpha2)./cosh(alpha2*(1-2*x)));

end