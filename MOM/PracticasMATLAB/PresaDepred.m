function PresaDepred(P0,N0,T)
% Modelo depredador-presa
% N(t): numero de presas en instante t
% P(t): numero de depredadores en instante t

% P'=-P+2PN
% N'=5N-3PN
% P(0)=P0
% N(0)=N0

% Argumentos de entrada:
% P0: numero inicial de depredadores
% N0: numero inicial de presas
% T: tiempo final de resolucion

% Puntos de equilibrio
eq1=[0;0];
eq2=[5/3;0.5];

% Dato inicial
y0=[P0;N0];

% funcion del segundo miembro del SDO
fun = @(t,y) [y(1).*(-1+2*y(2)); y(2).*(5-3*y(1))];

% resolvemos numericamente
[ts,ys]=ode45(fun,[0,T],y0);

% representacion grafica
close all

% trayectorias
figure(1)
hold on
plot(ts,ys,'LineWidth',1.4)
plot([0,0],[P0,N0],'g*','MarkerSize',16) %datos iniciales
mNP =max(max(ys));
axis ([0,T,0,1.2*mNP]) % ampliamos los ejes para que nos pinte 
                                % bien el legend

title (['Modelo presa-depredador. P0=',num2str(P0),' NO=',num2str(N0)])
legend ('Depredadores','Presas','Location','Best')

xlabel('tiempo')
ylabel('poblacion')

hold off
shg


% órbitas
figure(2)
hold on

plot(ys(:,1),ys(:,2), 'LineWidth',1.2) 
plot(P0,N0,'r.','MarkerSize',15) % vemos el sentido para abajo pq hemos 
                            % visto en la figura 1 que empieza decreciendo

% vamos a poner un vector orientacion
v=fun(0,y0);
quiver(P0,N0,v(1),v(2),0.2,'Color','m') %v(1) v(2) para darle x e y
%podemos usar help quiver para hacer vectores con direccion

% puntos de equilibro
plot(0,0,'k*','MarkerSize',13)
plot(eq2(1),eq2(2),'k*','MarkerSize',13)
title ('orbitas')
xlabel('depredadores')
ylabel('presas')

%control con insecticida
y00=[P0,N0/5]; %ya que pasa el N0 de 0.5 a 0.1

% resolucion numerica
[tsi,ysi]=ode45(fun,[0,T],y00);

% representacion grafica
figure(3)
hold on
plot(ts,ys(:,2),'LineWidth',1.2) % presas(insectos) sin insecticida
plot(tsi,ysi(:,2),'LineWidth',1.2) % presas(insectos) con insectida
legend('Insectos sin insecticida','Insectos con insecticida')

% calculo del intervalo de tiempo donde la actuacion biologica es mejor
% que la quimica

g = @(t) interp1(ts,ys(:,2),t) - interp1(tsi,ysi(:,2), t);
t1 = fzero(g,0.5);
t2 = fzero(g,2.4);

plot([t1,t2],[0,0], 'LineWidth',2.5,'Color','k')

shg

% Para calcular el periodo, sutituimos por ejemplo el 0,2 la grafica azul.
% Luego con el fzero buscamos otro valor del mismo 0,2 para calcular el 
% tiempo del periodo.

% PresaDepred(2.2,2.2,10)
% PresaDepred(2,0.5,10)