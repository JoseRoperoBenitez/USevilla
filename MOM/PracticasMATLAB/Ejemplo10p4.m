function Ejemplo10p4

%  resolvemos el ejercicio 10.4 de los apuntes de MATLAB

%cierre ventanas
close all

%funcion del segundo miembro
fun = @(t,y) 0.5*(10*t-log(y+1));

%resolvemos numericamente
[ts,ys]=ode45(fun,[0,1],1);
plot(ts,ys,'b','LineWidth',1.3)
hold on
grid on % para la malla de valores
psi =@(z) interp1(ts,ys,z)-1.5;
td=fzero(psi,.5);
plot(td,1.5,'r*','MarkerSize',13)
hold off
text(0.1,2.25, ['El punto de corte es: ',num2str(td)],'FontSize',15)
shg