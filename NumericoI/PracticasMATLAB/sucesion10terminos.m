% Ejercicio 29.

v = [];
v(1)=0.25;
for k = 2:10
    v(k) = (2*(v(k-1))-1)/((v(k-1)^2)+1);
   
end
disp (v)

% Ejercicio bucles.
% Ejercicio matriz.
% Ejercicio ecuaciones y gráficas. Línea discontinuas y esos comandos.
% tb title, leyenda, xlabel, ylabel.