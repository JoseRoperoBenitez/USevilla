%% Ej 47 (CÁLCULO PUNTOS DE CORTE)

fx = @(x) (x+2).*log(x-2);

gx = @(x) 0.3*(x+1).*(x-5).*(x-9);

x = linspace (2,16);
plot (x,fx(x),x,gx(x))

diferencia = @(x) fx(x) - gx(x);
sol1 = fzero (diferencia, 4)
sol2 = fzero (diferencia,11)
hold on
plot (sol1, fx(sol1),'s')
plot (sol2, fx(sol2),'o')
hold off

% No me dibuja los puntos NO ME DIBUJA LOS PUNTOS.
