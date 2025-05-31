%% Ejercicios día 1 clase

% a)

a = 2^(1/(2^3))

% b)


b = (4.1^(0.2+1)/2)/(2/0.1*(1/2)-0.4/2^(1/3))

format rat
%% Cosas básicas

%format long
%format short
%format rat

% exp(1) = e 

%% Construcción de vectores

% Vector fila

v = [1, -1, 0, sin(2.88)]

% Vector columna

w = [0; 1.003; 2; 3; 4; 5*pi]

% Matriz 3x4

j = [1, 2, 3, 4; 5, 6, 7, 8; 9, 10, 11, 12]

%% Generar vectores 

% Vector fila de a b con incremento de h

%a:h:b

% Igual que antes pero h=1

%a:b

% Vector fila de longitud n desde a hasta b

% linspace (a,b,n)

% Igual que antes pero n=100

% linspace (a,b)

% (Para matriz traspuesta usamos A'.

%% Matrices construidas con bloques

v1 = 1:4

v2 = [v1, 5; 0.1:0.1:0.5]

v3 = [v2', [11,12,13,14,15]']

format short

%% Generación de matrices habituales

% zeros (n,m) => matriz nxm con componentes todas 0

% ones (n,m) => matriz nxm con componentes todas 1

% eye (n,m) => matrizz nxm con diag principal 1 y resto 0

% diag (v) => matriz con la diagonal el vector v

% (Para dimension de matriz usamos el size)

% diag (v,k) =>  Si v es un vector, es una matriz cuadrada de ceros con
%                k-ésima superdiagonal = v


% diag (A) => diag principal de matriz A

% diag (A,k) => k-ésima superdiagonal de matriz A

% A (:) => saca los elem de A y los pone en columna.

%%




