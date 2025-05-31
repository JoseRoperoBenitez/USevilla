function VIH (x0,y0,v0,T)

%
% Resolvemos el modelo que estudia la evolución de la la población del
% virus del VIH:
% x' = l - dx -bxy   
% y' = bxy - ay       (lambda = l; beta = b)
% v' = Py - cv
% Argumentos de entrada
% x0: población de linfocitos TCD4+ inicial por mm^3
% y0: población de linfocitos TCD4+ infectados inicial por mm^3
% v0: población de virus VIH inicial por mm^3
% T : tiempo de resolución

% Datos 
l = 2;
d=0.01;
b=0.004;
a=0.33;
P=50;
c=log(2)/1.7;

% Dato inicial
Y0 = [x0;y0;v0];

% Segundo miembro de la ecuacion
f = @(t,y) [l-y(1).*(d+b*y(2)); y(2).*(b*y(1) - a); P*y(2) - c*y(3)];

% Resol numerica
[ts,ys] = ode45(f,[0,T], Y0);

% Representacion grafica

% Trayectoria x, y
close all
figure(1)
hold on
plot(ts,ys(:,1), 'LineWidth',1.3)
plot(ts,ys(:,2), 'LineWidth',1.2)
legend ('fun x', 'fun y')

%Trayectoria v
figure(2)
plot(ts,ys(:,3),'LineWidth',1.3)
legend ('población de virus VIH por mm^3')

% Orbita con la cond inicial
figure(3)
hold on
plot(ys(:,1), ys(:,3),'r') %orbita(x,v)
plot (x0,v0,'k*', 'MarkerSize',10)
legend ('Orbita (x,v)', 'Cond. iniciales')

figure(4)
hold on
plot(ys(:,1),ys(:,2))
xlabel('Linfocitos')
ylabel('Linfocitos infectados')
plot(x0,y0,'k*','MarkerSize',10)

% Tiempo en que la poblacion del virus alcanza el maximo y su valor
[maxv,inf] = max(ys(:,3));
tmax = ts(inf);
fprintf('La población alcanza el máximo en el tiempo %4.2f y toma el valor %4.5f',tmax,maxv)

% VIH (199,1,1,720)







