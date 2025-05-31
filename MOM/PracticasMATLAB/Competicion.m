function Competicion(N0,P0)

% resolvemos el modelo de competicion
% N' = aN - bNP
% P' = cP - dNP
% donde N y P representan dos especies que conviven y compiten en mismo 
% habitat

% Argumentos de entrada
% N0 : dato inicial de la poblacion N
% P0 : dato inicial de la poblacion P

% datos
a = 0.1;
b = 5;
c = 0.2;
d = 1;
T = 30;

% puntos de equilibrio
eq1 = [0;0];
eq2 = [c/d;a/b];

% dato inicial
y0 = [N0,P0];

% segundo miembro del sistema
fun = @(t,y) [(a-b*y(2)).*y(1); y(2).*(c-d*y(1))];

% resolvemos numericaente
% problema directo (hacia alante)
[ts1,ys1] = ode45(fun,[0,T],y0); 

% problema retrogado (hacia detras)
[ts2,ys2] = ode45(fun,[0,-T],y0); % el primer pto del intervalo es donde
                                  % tengo la cond inicial

% representacion grafica
close all

%trayectorias
figure(1)
hold on
plot(ts1,ys1(:,1),'LineWidth',1.2,'Color','b')
plot(ts1,ys1(:,2),'LineWidth',1.2,'Color','k')

plot(ts2,ys2(:,1),'LineWidth',1.2,'Color','b')
plot(ts2,ys2(:,2),'LineWidth',1.2,'Color','k')



%ptos de equilibrio
plot([-T,T],[0,0],'k--')
plot([-T,T],[eq2(1),eq2(1)],'g--')
plot([-T,T],[eq2(2),eq2(2)],'r--')

hold off
legend('Especie 1','Especie 2','Especie 1','Especie 2','Eq nulo', ...
    'Eq. especie 1','Eq. especie 2','Location','Best')
xlabel('tiempo')
ylabel('poblacion')
axis([-T,T,-.1,0.4])


% orbitas (diagrama de fases)
figure(2)
Nmax = 2*max(eq1(1),eq2(1));
Pmax = 2*max(eq1(2),eq2(2));
hold on 
plot (ys1(:,1),ys1(:,2),'b')
plot (ys2(:,1),ys2(:,2),'g')
plot(N0,P0,'m.','MarkerSize',17) %dato inicial
plot(eq1(1),eq1(2),'c+') %pto equilibrio
plot(eq2(1),eq2(2),'k+') %pto equilibrio

legend('semiorbita positiva','semiorbita negativa','dato inicial', ...
    'eq. 1', 'eq.2')
title ('Plano de fases')
xlabel('Especie 1 (N)')
ylabel('Especie 2 (P)')
axis ([0,Nmax,0,Pmax])

% plano de fase
figure(3)
hold on
N=50; % numero de experimentos
axis([0,2*eq2(1),0,2*eq2(2)])

% generamos datos iniciales aleatorios
N0 = 2*eq2(1)*rand(1,N);  %estan entre 0 y dos veces el eq2
P0 = 2*eq2(2)*rand(1,N);

% resolucion iterada

for k=1:N
    y0=[N0(k);P0(k)];
    % problema directo (hacia alante)
    [ts1,ys1] = ode45(fun,[0,T],y0); 
    % problema retrogado (hacia detras)
    [ts2,ys2] = ode45(fun,[0,-T],y0);
    %representacion grafica
    plot(ys1(:,1),ys1(:,2),'b')
    plot(ys2(:,1),ys2(:,2), 'r')
    plot(N0(k),P0(k),'k*')
    plot(eq2(1),eq2(2),'c.','MarkerSize',17) %pto de equilibrio, en medio
end
hold off
title ('Plano de fases')
shg