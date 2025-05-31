function Cortes
%
% f(x) y g (x). Dibujarlas en intervalo adecuado, que se vean ptos corte.
% Calcular cordenadas de dos puntos de corte. Dibujar puntos corte, leyenda
% ejex y ejey.
% 

f = @(x) (1 + x.^2).^(1/3) + (1/5)*exp(x);
g = @(x) -x.^2 + 2*x + 13;
x = linspace (-6,6);
hold on
plot (x,f(x),'r')
plot (x,g(x),'b')

h = @(x) f(x) - g(x);
sol1 = fzero (h,[-4,0])
sol2 = fzero (h,[0,4])

plot (sol1, f(sol1), 'k.', "MarkerSize", 15)
plot (sol2, f(sol2), 'k.', "MarkerSize", 15)

legend ('y = f(x)','y = g(x)')
xlabel('Eje x')
ylabel('Eje y')
title ('José Ropero')
hold off 
shg



