function ej66

M = load('concentracion.dat');
close all
t = M(:,1); y= M(:,2);
n = length (t);
c=polyfit(t,log(y),1); % recta de regresion con cambio de variable
z = linspace(min(t), max(t));
plot(t,y, '.r', 'MarkerSize',14); hold on
a = c(1);
b = exp(c(2));
plot(z,b*exp(a*z),'b') %esta es la b*exp(at)


