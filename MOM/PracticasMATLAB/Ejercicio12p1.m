function Ejercicio12p1
% resolvemos el problema de minimos de Ejercicio 12.1

% definimos funcion a minimizar

funJ = @(x) -x(1)*x(2)*x(3);

% condiciones lineales de desigualdad
c= [1,2,3;-1,-2,-3];
d= [72;0];

%restricciones puntuales
ci=[-Inf;-Inf;-Inf];
cs=[Inf;Inf;Inf];

%opciones de busqueda
opt= optimset('Algorithm','active-set','Display','iter');

% aproximacion inicial
x0= [10;10;10];

% resolvemos numericamente

% [x,val]=fmincon(funJ,x0,c,d) % tenemos el punto donde se alcanza y el valor 
                             % del minimo. con esta linea ya saldria
[x,val]=fmincon(funJ,x0,c,d,[],[],ci,cs,[],opt)
