function ej2
A=[-58 -3
    23 2
    72 4];
x=A(:,1);
y=A(:,2);
intervalo=linspace(min(x),max(x));

intertrozos=interp1(x,y,intervalo);
splinecubico=spline(x,y,intervalo);
close all;
hold on;
plot(intervalo,intertrozos,intervalo,splinecubico);
plot(x,y,'.r','MarkerSize',14);
xline(0);yline(0);
legend('interpolacion a trozos','spline','puntos soporte','eje X','eje Y','Location','Best');

shg;

%c
sp=@(t) spline(x,y,t);
h=@(t) abs(sp(t));
area=integral(h,-55,65);
disp(num2str(area));
