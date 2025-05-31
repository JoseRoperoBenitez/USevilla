%% Ejercicio 11

fx = @(x) 1./(x.^2 +1);
xf = linspace (-1,2);
plot(xf,fx(xf));

axis ([-1,2 , -0.5, 1.2])
shg


