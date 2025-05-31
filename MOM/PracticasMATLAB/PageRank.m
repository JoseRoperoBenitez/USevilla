function PageRank
% Calculamos el vecto PageRank de una red creada de forma aleatoria

%Reiniciamps la semilla d enumerp aleatorio.
rng('shuffle')

% Datos necesarios
% N: numero de paginas web de la red
%nme: numero de enlace por pagina
%alpha: factor de amortiguacion
%epsi: cuidado no poner eps. Tolerancia del error

N=5000;
nme=7;
alpha=0.98;
epsi=1.e-15;

%Calculamos la matriz de adyaciencia.

A=rand(N,N); %mirar en help rand
L = A<nme/N; %hay que tranformar los booleanos en numero.
A=L+0; %matriz numerica de 0 y 1
clear L; %eliminamos de la memoria L

%Imponemos que los elementos diagnianoles de A sean nulos.

for k=1:N
    A(k,k)=0;
end

%Calculamos la matriz estocástica asociada

z = sum(A); %sumamos por columnas
z0=find(z==0);%guardamos en z0 las componentes donde z es 0
z(z0)=ones(size(z0)); % ponemos un uno en los ceros

P=A*diag(1./z); %cada col i la dividimos por z. Pero hay q tener cuidao con div por 0.

%matriz hueca es aquella que tiene muchos 0 en ella
% una matriz sparse va a guardar solamente los elementos no son 0 de una
% matriz hueca.

PS = sparse(P);

%Bytes de matriz llena
whos P
%Bytes de matriz hueca
whos PS

% la matriz es la misma lo único que ganamos bastante en memoria

% visualizacion de la matriz hueca (hay muchos puntos blancos)
close all
figure(1)
spy(P) %de sparce
shg

clear P;

%A la matriz que le vamos a aplicar el metodo de la potencia es a PS.
%Obviamos las matrices con cols de 0.


% Programamos el método de la potencia
v=ones(N,1)/N; %todas con equiprobabilidad (ir de una pag a otra)
% Inicializacion
x0=v;

%Iteraciones
for k=1:100
    x1=alpha*(PS*x0);
    gammak=1-norm(x1,1);
    x1=x1+gammak*v;
    err=norm(x0-x1);
    if err<epsi
        fprintf('\n')
        fprintf('El algoritmo converge en %3i iteraciones',k)
        x1; %vector de 5000 componentes
        figure(2)
        histogram(x1) %mejor representacion que da la misma info
        return
    end
    x0=x1;
end