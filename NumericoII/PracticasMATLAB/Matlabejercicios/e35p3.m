function e35p3

f = @(x) cos(x).*cosh(x)+1;
x = linspace (0,15);

% dfx = @(x) cos(x)*sinh(x)-cosh(x)*sin(x);
fx = f(x);
close all
plot (x,fx,'b');
hold on 
plot ([0,15],[0,0],'k')
shg
figure
x2 = linspace(10,14);
fx2=f(x2);
plot(x2,fx2,'b')
hold on
plot([10,14],[0,0])
shg
pause
hold off

figure(1)
x = linspace(0,8);
fx= f(x);
plot(x,fx,'b')
hold on
plot([0 8],[0 0])
shg
pause
x=linspace (0,3);
fx= f(x);
hold off
plot(x,fx,'b')
hold on
plot([0 3], [0 0])
shg
pause
figure(2)
x2= linspace(10,14.3);
fx2=f(x2);
plot(x2,fx2,'b')
hold on
plot([10 14.3], [0 0])
shg



% [x1,Iter] = Newton27 (fx, dfx, 2, 100, 1e-14)
% [x2,Iter] = Newton27 (fx, dfx, 5, 100, 1e-14)
% [x3,Iter] = Newton27 (fx, dfx, 8, 100, 1e-14)
% [x4,Iter] = Newton27 (fx, dfx, 11, 100, 1e-14)
% [x5,Iter] = Newton27 (fx, dfx, 14, 100, 1e-14)

% ES MUY IMPORTANTE LOCALIZAR LOS PUNTOS INICIALES, sino, nos va a dar
% resultados no correctos.






% En este intervalo no se ve muy bien las aproximaciones por tantos vamos a
% trocear la grafica

% >> [x,Iter] = Newton28 (fx, dfx, 1, 100, 1e-2)