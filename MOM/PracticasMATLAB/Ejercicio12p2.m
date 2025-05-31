function Ejercicio12p2
% resolvemos el problema de minimos de Ejercicio 12.2

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
[x,val]=fmincon(funJ,x0,c,d,[],[],ci,cs,@resnolin,opt) %ojo con la mfun

end

function [c,ceq] = resnolin(x) 
%m-funcion para las retricciones no lineles
% lo definimos así pq nos da fallo haciendolo por separado
c= x(1)^2 + x(2)^2 + x(3)^2 - 500;
ceq= 0; %pq hay solo una ecuacion

end