function Ejemplo10p6

close all

%segundo miembro
F=@(t,y) [0.5*y(1)-0.2*y(1)*y(2);
        -0.5*y(2)+0.1*y(1)*y(2)];

%dato inicial
y0= [4;4];

%resolvemos numericamente
[ts,ys]=ode45(F,[0,30],y0);

%representacion grafica en el plano de fases
plot(ys(:,1),ys(:,2))
title('plano de fase: orbita')
xlabel('y_1')
ylabel('y_2')

figure(2)
plot(ts,[ys(:,1),ys(:,2)])
title('trayectorias')
legend ('y_1','y_2')