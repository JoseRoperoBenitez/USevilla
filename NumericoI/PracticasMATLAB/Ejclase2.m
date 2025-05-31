%% Apuntes de clase día 2

% Ejercicio 38

%% d)
Ad = [1,-1,1; -1,5,1; 1,1,3];
bd = [1,1,0];
bd = bd';
Abd = [Ad,bd];
rangoA = rank(Ad)
rangoAmp = rank(Abd)
xd = Ad\bd 

%PARA COMPROBAR QUE LA SOLUCIÓN QUE
% DA ESTÁ BIEN SE ACABA CON A*sol => Nos da bd.

% No ponemos ; cuando queremos que al cargar nos muestre lo
% que no le ponemos el ;

%% e)

Ae = [0,2,0,4; 2,2,3,2; 4,-3,0,1; 6,1,-1,-5];
be = [0,-2,-7,6];
be = be';
Abe = [Ae,be];
rangoAe = rank(Ae)
rangoAmp = rank(Abe)
xe = Ae \ be


%% Vemos en otro fichero (areaequi) la creación de funciones

%% %% Creación de funciones anónimas

% Para crear funciones como f(x) ponemos @(x) y la función.
area_circulo = @(r) pi * r^2;

semicirc = area_circulo(3)/2;

%% Otro ejemplo fun anonimas 
% (se recomienda siempre poner punto dentro de las operaciones)


a=2;
mifun = @(x,t) sin(a*x).*cos(t/a);
pepe = mifun(pi/4,1);


% Se pone el punto entre seno y coseno pq el x puede ser un vector, sin
% embargo, no se pone entre a*x pq a hemos visto ya que es un número. 