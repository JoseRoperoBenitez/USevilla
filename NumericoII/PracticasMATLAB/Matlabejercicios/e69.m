function e69

f = @(t,y) t.*exp(t./y);

close all

[tt,yy] = ode45(f,[0,.632],1);
plot (tt,yy)
disp('El valor en el punto 0.632: ')
disp (yy(end))
% Otra forma de verlo
hold on
plot (.632, yy(end),'.r', 'MarkerSize',20)
text (.3,1.2,['valor de la sol en 0.632: y(.632)=',...
    num2str(yy(end))])
title(['Valor de la sol en 0.632: y(.632)=',...
    num2str(yy(end))])
shg