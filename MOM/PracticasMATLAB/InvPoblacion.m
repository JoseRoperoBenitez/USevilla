function [C] = InvPoblacion(k,N0,U,tobs,Nobs,Ccero)
% Ejercicio 11 examenes años anteriores
%
% N = N(t): numero de individuos en una poblacion
% U: umbral inferior
% C: el techo tq 0<= U < C
%
%

% datos
ci=0;
cs=Inf;

% funcion a minimizar
funJ = @(C) funaux (C,k,N0,U,tobs,Nobs);

% opciones
op = optimset('Tolfun',1.e-15,'TolX',1.e-10);

% resol numerica del pb de minimos
[C,CostCop] = fmincon (funJ,Ccero,[],[],[],[],ci,cs,[],op);

%representacion en pantalla
fprintf('\n')
fprintf('--> Valor optimo del techo C=%12.7f \n',C)
fprintf('--> Coste: %12.7f \n',CostCop)

%representacion grafica
T = tobs(end);
fun = @(t,N) k*(N - U)*(C - N);
sol = ode45(fun,[0,T],N0);

xx = linspace(0,T);
uu = deval(sol,xx);

close all
plot(xx,uu,'r')
hold on
plot(tobs,Nobs,'k.','MarkerSize',12)
legend ('funcion','valores obs','Location','Best')
text (0.5,1500,['C= ',num2str(C)])
hold off
shg

end

function val = funaux (C,k,N0,U, tobs,Nobs)

% datos
T = tobs(end);
fun = @(t,N) k*(N - U)*(C - N);
sol = ode45(fun,[0,T],N0);
Ni = deval (sol,tobs);

val = sum ((Ni-Nobs).^2);

end

% InvPoblacion(3.5e-5,1000,30,[1,3,6],[1000,1500,3000],3000) 