function FHN (a,b,I,v0,w0,T)

%
% Vamos a resolver el modelo de FitzHugh-Nagumo que simula eol
% comportamiento del potencial eléctrico de una neurona:
% v' = v-v^3/3-w+I
% w' = v+a-bw

% Argumentos de entrada
% a,b: constantes mayores que 0
% I: estímulo externo
% v0: potencial eléctrico de una neurona en tiempo t=0
% w0: variable iónica de recuperación en el tiempo t=0
% T: tiempo de resolución

% Datos para resolucion
% a = 0.12;
% b = 0.8;
% I = 0.372;
% v0 = 0.4;
% w0 = 0.8;
% T = 80;
% FHN (0.12,0.8,0.372,0.4,0.8,80)

% Dato inicial
y0 = [v0;w0];

% segundo miembro del sistema
fun = @(t,y) [y(1)-(y(1).^3)./3-y(2) + I; y(1)+a-b*y(2)];

% resol numerica
[ts,ys] = ode45 (fun,[0,T], y0);

% Representacion grafica
% trayectoria
close all
figure(1)
hold on
plot(ts,ys(:,1),'LineWidth',1.3)
plot(ts,ys(:,2),'LineWidth',1.3)
legend('Potencial electrico','Variable ionica')
title('trayectoria')

% orbita
figure(2)
hold on
plot(ys(:,1), ys(:,2))
title('Orbita(v,w)')
xlabel('Potencial electrico')
ylabel('variable ionica')


% Apartado c)
x0 = [0.6,0.9];
r = 0.01;
z = linspace(0,2*pi);
y1 = x0(1) + r.*sin(z);
y2 = x0(2) + r.*cos(z); % Bola centro x0, radio r
figure(2)
hold on
plot(v0,w0,'r*','MarkerSize',10)
plot (y1,y2,'k','LineWidth',1.5,'LineStyle','-')

% hacemos bucle para ver el tiempo minimo
m = length(ts);
for i =1:m
    if norm(ys(i,:)-x0) <= r 
        tmin=ts(i);
        fprintf('El valor t* es: %8.4f \n', tmin)
        return
    end
end
