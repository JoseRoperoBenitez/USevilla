function ej69est

f = @(t,y) t.*exp(t./y);

[tt,yy] = ode45 (f,[0,.632], 1);

plot(tt,yy)

disp('El valor en tf = 0.632 es: ')
disp (yy(end))

% Representacion

hold on
plot (.632, yy(end), '.r', 'MarkerSize', 10)

text(.35,1.285, ['El valor en tf es: ', num2str(yy(end))])
title(['Valor de la sol en 0.632: y(.632)=',...
    num2str(yy(end))])

shg

shg