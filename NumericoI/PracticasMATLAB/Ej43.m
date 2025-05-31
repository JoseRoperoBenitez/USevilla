%Ej 43

f3 = @(x) 2.^x - x-3;

solucion3 = fzero (f3, [-3,0]);
solucion32 = fzero (f3, [0,3]);