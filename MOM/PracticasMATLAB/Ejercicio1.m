function Ejercicio1

%Resol ej1 de relacion de problemas

% a) 

x = [0,2,3,5,6,8,9,11,12,14,15];
y = [10,20,30,-10,10,10,10.5,15,50,60,85];

% calculamos el pol de interp. de Lagrange
% numero d ptos a interpolar
N = length(x);

% pol. inter. Lagrange
coef= polyfit(x,y,N-1);
p=@(z) polyval(coef,z);

% b) pol. interp. lineal a trozos
p1t = @(z) interp1(x,y,z);

% c) Evaluamos las fun en x=1.
p(1)
p1t(1)

% d) Representacion grafica
close all

z = linspace(0,15,200); %interval [0,15] con 200 componentes

pz=p(z);
h1 = plot(z,pz,'b');
hold on
h2 = plot(x,y,'k');
plot(x,y,'r*','MarkerSize',13)
legend ([h1,h2],'Pol.Int.Lagrange','Pol.Int.Lineal a trozos',...
    'Location','Best')
hold off
shg


