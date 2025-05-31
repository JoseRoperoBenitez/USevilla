%% Ejercicio 7

A = diag (3*ones(1,20))+ diag(-ones(1,19),1) + diag(-ones (1,19),-1);

B = diag(1:1:20) + diag(-ones(1,19),1) + diag(-ones(1,19),-1) + 
diag(-2*ones(1,18),2)+ diag(-2*ones(1,18),-2);

% HECHO MEJOR EN ConstruccionMatriz.

