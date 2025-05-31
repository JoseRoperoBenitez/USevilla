function ej66estudio

M = load('concentracion.dat');

t = M(:,1); % Tiempo en horas
y = M(:,2); % Concentracion de sustancia

plot(t,y,'.r','MarkerSize', 10)

% n = length(t);
z = linspace (min(t), max(t));

c = polyfit (t,log(y), 1);

% Recta de regresión: y= c(1)*t + c(2)

a = c(1);
b = exp(c(2));

hold on
plot (z, b*exp(a*z), 'b')

shg
