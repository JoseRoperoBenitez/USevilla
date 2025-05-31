function ej59

M = load ('censo.dat');
close all % cerramos las graficas
plot (M(:,1),M(:,2))
shg
p1956 = interp1(M(:,1),M(:,2),1956);
hold on
plot (1956,p1956, '.r', 'MarkerSize',10)
text(1958,p1956,['poblacion esperada:', num2str(p1956)]) % para texto en la grafica
shg