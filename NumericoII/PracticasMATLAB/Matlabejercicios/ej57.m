function ej57

x = [1 2 3];
y = [-3 1 3];
coef = polyfit(x,y,2);
z = linspace(0,7);
pz = polyval(coef,z);
close all % eliminamos la grafica previa
plot (x,y,'.r','MarkerSize',14)
hold on
plot(z,pz,'b')
plot([-1 7],[0 0], 'k')
plot ([0 0], [-10 4],'k')
legend('puntos interpolados','p2 interpo.global','Location','best')
shg