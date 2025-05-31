function [flag1,flag2] = Pesca(q,y0,T)
% resolvemos ejercicio 6 relacion
%Modelo de pesca
%y'=r*y*log(k/y)-q*y
%y(0)=y0
%
%y(t) representa la masa de peces en el instante t
%Argumento de entrada
%q: factor de pesca
%y0: masa inicial
%T: tiempo final de resolución
%
%Argumento de salida:
%flag1=1 si existe t1 tq y(t1)=y0/2
%flag1=0 c.c
%
%flag2=1 si existe t2 tq y(t2)<=5
%flag2=0 c.c

% Apartado 1

% Datos
r=0.2;
K=27;
y02=0.5*y0;

% Equilibrio
yeq=K*exp(-q/r);

% Definimos segundo miembro de la edo
fun = @(t,y) r*y.*log(K./y)-q*y;

% Resolvemos numericamente
[ts,ys] = ode45(fun,[0,T],y0);

% Representacion grafica
close all
figure(1)
hold on
plot(ts,ys,'LineWidth',1.2)
plot([0,T],[yeq,yeq],'r','LineWidth',0.9)
plot(0,y0,'g*','MarkerSize',12)

hold off
axis([0,T,0,2*max(yeq,y0)])
title('Modelo de Pesca')
legend('Masa de peces','Pto equilibrio','Dato inicial','Location','best')

% >> Pesca(0.05,10,20)
% >> Pesca(0.3,10,20)

% Apartado 2

%Cálculo de t1
%Me ayudo de comando ginput(1) para señalar ptos críticos en la ventana
%gráfica

if (y02>yeq)
    f1=@(t) interp1(ts,ys,t)-y02;
    grid on
    [x0,z0]=ginput(1);
    t1 = fzero(f1,x0);
    flag1=1;
    msg1=['La mitad del dato inicial se alcanza para t=',num2str(t1)];
else
    flag1=0;
    msg1='No se alcanza la mitad del dato inical';
end

% Apartado 3

%Cálculo de t2
if y0<=5
    t2=0;
    flag2=1;
    msg2='Se tiene que y(0) es menor o igual que 5';
else
    if y0 < 5
        f2=@(t) interp1(ts,ys,t)-5;
        grid on
        [x0,z0]=ginput(1);
        t2=fzero(f2,x0);
        flag2=1;
        msg2=['Se tiene y(t)<= 5 para t=',num2str(t2)];
    else
        flag2=0;
        msg2='No exite t tal que y(t)<=5';
    end
end

% >> [fg1,fg2] = Pesca(0.3,10,20)
% >> [fg1,fg2] = Pesca(0.05,10,20)
% >> [fg1,fg2] = Pesca(0.3,14,20)
% >> [fg1,fg2] = Pesca(0.4,14,20)

% Representamos graficamente los valores de t1 y t2

figure(2)
axis([0,T,-2,1.2*max(y0,yeq)])
hold on
plot(ts,ys,'LineWidth',1.2)
plot([0,T],[yeq,yeq],'r','LineWidth',0.9)
plot(0,y0,'g*','MarkerSize',12)
plot([0,T],[y02,y02],'k--','LineWidth',1.1)
plot([0,T],[5,5],'k-.','LineWidth',1.1)

title('Modelo de pesca')
legend('Masa de peces','Equilibrio','Dato inicial','y=y0/2','y(t)=5', ...
    'Location','best')

if flag1
    plot(t1,y02,'m*','MarkerSize',15)
end

if flag2
    plot(t2,5,'y*','MarkerSize',15)
end

text(1,0,msg1,'FontSize',13)
text(1,-1,msg2,'FontSize',13)

% >> [fg1,fg2] = Pesca(0.3,10,20)
% >> [fg1,fg2] = Pesca(0.05,10,20)
% >> [fg1,fg2] = Pesca(0.3,14,20)
% >> [fg1,fg2] = Pesca(0.4,14,20)
