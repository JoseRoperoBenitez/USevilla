function Ejemplo10p1
% ejercicio 10.1 de apuntes de matlab

% definimos la funcion f(t,y)

% f=@(t,y) 5*y;

% resolvemos el problema de Cauchy

% ode45(f,[0,1],1)

% Otra forma de obtenerlo mediante una m-funcion(ponemos el @)
[t,y]=ode45(@funej10p1,[0,1],1) % guardamos las soluciones numericas

% comparamos con la solucion exacta y=exp(5t)

hold on
t=linspace(0,1); %discretizamos el intervalo
plot(t,exp(5*t),'r')
hold off
shg

% Se puede calcular entonces el error sustituyendo en t la fun

