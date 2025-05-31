%% Ejercicio 28
% Raiz cuadrada de la suma de los 100 primeros impares.

sumaimp = 0;
for k = 1:2:200
    sumaimp = sumaimp + k;
end
disp(sqrt(sumaimp))