function SIR_2(beta,gamma,S0,I0,R0,T)
%Modelo SIR...

%Argumentos de entrada
%beta: constante de contagio
%gamma: constante de recuperación
%S0: dato inicial de suceptibles
%I0: dato inicial de infectados
%R0: dato inical de recuperados
%T: tiempo final de resolución

%Datos:
N=S0+I0+R0;

%Dato inicial
y0=[S0;I0;R0];

%Función del segundo miembro
fun=@(t,y) [-beta*y(2).*y(1); (beta*y(1)-gamma).*y(2); gamma*y(2)];

%Resolvemos numericamente
[ts,ys]=ode45(fun,[0,T],y0);

%Representación gráfica
close all
%Trayectorias
figure(1)
plot(ts,ys,'LineWidth',1.2)
hold on
plot([0,T],[N,N],'LineWidth',1.2)

legend('Suceptibles','Infectados','Recuperados','Población Total','Location','Best')
title('Modelo SIR')
axis([0,T,0,1.1*N])

%orbita (I,R)
figure(2)
axis([0,N,0,N])
hold on
plot(ys(:,2),ys(:,3),'LineWidth',1.2)
xlabel('Infectados')
ylabel('Recuperados')

%orbita (S,I)
figure(3)
axis([0,N,0,N])
hold on
plot(ys(:,1),ys(:,2),'LineWidth',1.2)
xlabel('Infectados')
ylabel('Suceptibles')

%orbita (S,R)
figure(4)
axis([0,N,0,N])
hold on
plot(ys(:,1),ys(:,3),'LineWidth',1.2)
xlabel('Recuperados')
ylabel('Suceptibles')

% SIR(0.001,0.007,120,10,0,365)
% SIR(0.001,0.007,120,0,30,365)
% SIR(0.001,0.007,0,100,30,365)