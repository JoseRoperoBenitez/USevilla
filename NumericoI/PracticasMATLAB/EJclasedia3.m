%% Ejercicios 3ª Clase

%% Uso del roots

% Se pone el polinommio expresado con sus números en función del grado de
% mayor a manor

p = [1,-9,-1,5];
roots (p);

%% Uso del fzero



% El 1 indica el punto inicial. Podemos poner otro número o un intervalo.

fun = @(x) x + log(x/3);
sol = fzero (fun,1);
x = linspace (0.5,1.5);
plot (x,(fun(x)));
hold on
plot([0.5,1.5],[0,0]);
plot (sol,fun(sol),'k.','MarkerSize',30)
hold off


% En el fzero, el segundo valor es el xcero (primer valor de la x).

%% Operacciones de comparación

% Matlab devuelve 1 si es TRUE y 0 es FALSE.

% 3 == 3 (igual a)
% 3 ~= 4 (no igual a)
% < (menor que)
% > (mayor que)
% <= (menor o igual que)

% Para comprobar que x pertenece a un conjunto [a,b]:
% x >= a & x <= b 

% find(v) trabaja con opeeradores lógicos devolviendo los elementos que son
% mayores que 0.











