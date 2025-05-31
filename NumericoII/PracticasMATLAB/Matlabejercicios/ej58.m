function ej58

x = [0 2 3 5 6 8 9 11 12 14 15];
y = [10 20 30 -10 10 10 10.5 15 50 60 85];

n = length (x);
coef = polyfit(x,y,n-1); %p.1 global
z = linspace(min(x),max(x));
pz = polyval(coef,z);
close all % eliminamos la grafica previa
plot (x,y,'.r','MarkerSize',14)
hold on
plot(z,pz,'b')
pz2 = interp1(x,y,z);
plot(z,pz2)
legend('puntos interpolados','p2 interpo.global','p1 a trozos', 'Location','best')
shg