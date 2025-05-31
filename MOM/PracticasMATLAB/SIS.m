function SIS(beta,gamma,N,I0,T)

%Resolvemos modelo SIS...

%Argumentos de entrada
%beta: constante de contagio
%gamma: constante de recuperación
%N: población total
%I0: dato inicial de infectados
%T: tiempo final de resolución

% Datos
%Datos:
S0=N-I0;
y0=[I0;S0];
bg=beta/gamma;
R0=N*bg;

% Equilibrios
Se=gamma/beta;
Ie=N-Se;

%Definimos segundo miembro del sistema
fun= @(t,y) [y(1).*(beta*y(2)-gamma);y(1).*(gamma-beta*y(2))];

%Resolvemos numericamente
[ts,ys]=ode45(fun,[0,T],y0);


%Representación gráfica
close all
plot(ts,ys,'LineWidth',1.2)
hold on
plot([0,T],[N,N],'r','LineWidth',1.2)
plot([0,T],[Ie,Ie],'k--')
plot([0,T],[Se,Se],'k-.')
axis([0,T,0,1.1*N])


hold off
title(['Modelo SIS.  \beta=',num2str(beta),' \gamma=',num2str(gamma),' R0=',num2str(R0)])
legend('Infectados', 'Suceptibles','Población Total','Location','Best')
shg

% SIS(0.001,0.08,200,30,90)
% SIS(0.0005,0.08,200,15,120)
% SIS(0.0005,0.08,200,30,90)
% SIS(0.0005,0.008,130,30,120)
% SIS(0.0005,0.08,130,15,120)



