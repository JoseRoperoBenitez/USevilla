function ej70est

f = @(t,y) -2*y;

[tt,yy] = ode45 (f, [0,2], 10);

plot (tt,yy,'k','LineWidth',1.1)

hold on
exacta = 10*exp(-2*tt);
plot(tt,exacta,'*r')
shg